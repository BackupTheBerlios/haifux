#!/usr/bin/perl -w 

use strict;

use FileHandle;

use Data::Dumper;

use Data;



my @lectures_flat;

my @this_time = localtime(time());
my ($this_day, $this_month, $this_year) = @this_time[3,4,5];
$this_year += 1900;
$this_month++;
my %series_indexes = ();
foreach my $year (sort { $a <=> $b } keys(%lectures))
{
    my $lect_idx = 0;
    foreach my $lecture (@{$lectures{$year}})
    {
        my %lecture_copy = %$lecture;
        foreach my $field (qw(d t l s))
        {
            if (!exists($lecture_copy{$field}))
            {
                die "Field '${field}' is not present in lecture No. $lect_idx" . 
                    "of the year $year. Dump Follows:";

                my $d = Data::Dumper->new([$lecture], ["\$lecture"]);
                print $d->Dump();
            }
        }        
        $lecture_copy{'d'} .= "/$year"; 
        if (!exists($lecture_copy{'comments'}))
        {
            $lecture_copy{'comments'} = "";            
        }
        if (!exists($lecture_copy{'series'}))
        {
            $lecture_copy{'series'} = "default";
        }
        $series_indexes{$lecture_copy{'series'}} = 1;
        push @lectures_flat, {%lecture_copy };
    }
    continue
    {
        $lect_idx++;
    }
}

my $dest_dir = "./dest/";
if (! -d $dest_dir)
{
    mkdir($dest_dir);
}

my @files = 
(
    {
        'id' => "all",
        'url' => "all.html",
        't_match' => ".*",
        '<title>' => "Haifa Linux Club (All Lectures)",
        'h1_title' => "Haifa Linux Club - All the Lectures",
    },
    {
        'id' => "network",
        'url' => "network.html",
        't_match' => "network",
        '<title>' => "Haifa Linux Club (Networking Lectures)",
        'h1_title' => "Haifa Linux Club - Networking Lectures",
    },
    {
        'id' => "kernel",
        'url' => "kernel.html",
        't_match' => "kernel",
        '<title>' => "Haifa Linux Club (Kernel Lectures)",
        'h1_title' => "Haifa Linux Club - Kernel Lectures",
    },
    {
        'id' => "security",
        'url' => "security.html",
        't_match' => "security",
        '<title>' => "Haifa Linux Club (Security Lectures)",
        'h1_title' => "Haifa Linux Club - Security Lectures",
    },
    {
        'id' => "programming",
        'url' => "programming.html",
        't_match' => "prog",
        '<title>' => "Haifa Linux Club (Programming Related Lectures)",
        'h1_title' => "Haifa Linux Club - Programming Related Lectures",
    },
    {
        'id' => "util",
        'url' => "util.html",
        't_match' => "tools",
        '<title>' => "Haifa Linux Club (Tools and Utilities Lectures)",
        'h1_title' => "Haifa Linux Club - Tools and Utilities Lectures",
    },
 
    
);

foreach my $f (@files)
{
    $f->{'buffer'} = "";
}


my $print_topic_files = sub
{
    my $topics = shift;
    if (ref($topics) eq "")
    {
        $topics = [ $topics ];
    }
    foreach my $file (@files)
    {
        my $pattern = $file->{'t_match'};
        if (grep { ($_ eq "all") || ($_ =~ m/^$pattern$/) } @$topics)
        {
            $file->{'buffer'} .= join("", (map { (ref($_) eq "CODE" ? $_->($file) : $_) } @_));
        }
    }
};

my $print_all_files = sub {    
    return $print_topic_files->("all", @_);
};


$print_all_files->(
    sub { 
        my $file = shift; 
        return ("<html>\n",
            "<head><title>$file->{'<title>'}</title></head>\n",
            "<body bgcolor=\"white\">\n",
            "<div align=\"center\"><h1>$file->{'h1_title'}</h1></div>\n",
            "<h2>Past Lectures</h2>\n",
            ) 
        }
    );
            
my $table_headers =  
    "<table border=\"1\">\n" .
    "<tr>\n" .
    join("", map { "<td>$_</td>\n" } ("Lecture Number", "Subject", "Lecturer", "Date", "Comments or Links")) .
    "</tr>\n";

$print_all_files->($table_headers);
    
my ($lecture);
my $is_future = 0;

foreach $lecture (@lectures_flat)
{
    my @fields;

    # Generate the lecture number
    my $series = $lecture->{'series'};
    my $idx_in_series = $series_indexes{$series};
    push @fields, $series_map{$series}->{'lecture_num_template'}->($idx_in_series);

    # Generate the subject

    my $lecturer_id = $lecture->{'l'};

    $lecturer_id = 
        (exists($lecturer_aliases{$lecturer_id}) ? 
            $lecturer_aliases{$lecturer_id} :
            $lecturer_id
        );

    if (!exists($lecturers{$lecturer_id}))
    {
        die "Unknown lecturer ID '$lecturer_id' in lecture of date " . $lecture->{'d'};
    }

    my $lecturer_record = $lecturers{$lecturer_id};

    my $subject_render = 
        (exists($lecture->{'subject_render'}) ? 
            $lecture->{'subject_render'} :
            $lecturer_record->{'subject_render'}
        );

    push @fields, 
        $subject_render->(
            $lecture,
            $idx_in_series
        );

    # Generate the lecturer field

    my $lecturer_field;
    my $name_render_type = $lecturer_record->{'name_render_type'};
    if ($name_render_type eq "email")
    {
        $lecturer_field = "<a href=\"mailto:" . $lecturer_record->{'email'} . 
        "\">" . $lecturer_record->{'name'} . "</a>";
    }
    elsif ($name_render_type eq "plain")
    {
        $lecturer_field = $lecturer_record->{'name'};
    }
    else
    {
        die ("Uknown lecturer's name_render_type field for " . 
            "lecturer '$lecturer_id'");
    }

    push @fields, $lecturer_field;
    
    # Generate the date field
    
    my $date = $lecture->{'d'};

    if (! $is_future )
    {
        my ($date_day, $date_month, $date_year) = split(m!/!, $date);

        my $cmp_val = 
            (($date_year <=> $this_year) || 
            ($date_month <=> $this_month) ||
            ($date_day <=> $this_day));

        if ($cmp_val >= 0)
        {
            $print_all_files->(
                "</table>\n",
                "<h2>Future Lectures</h2>\n",
                $table_headers
            );
            $is_future = 1;
        }
    }
        
    
    $date =~ s{^(\d+)/(\d+)/\d{2}(\d{2})$}{$1/$2/$3};
    
    push @fields, $date;

    # Generate the comments field

    push @fields, $lecture->{'comments'};

    my $rendered_lecture = "<tr>\n" . join("", map { "<td>\n$_\n</td>\n" } @fields) . "</tr>\n";

    $print_topic_files->($lecture->{'t'}, $rendered_lecture);
}
continue
{
    $series_indexes{$lecture->{'series'}}++;
}

$print_all_files->("</table>\n", "</body>\n", "</html>\n");

foreach my $f (@files)
{
    open O, ">$dest_dir/$f->{'url'}";
    print O $f->{'buffer'};
    close(O);
}
