#!/usr/bin/perl -w 

use strict;

use Data::Dumper;

use Data;



my @lectures_flat;

my @this_time = localtime(time());
my ($this_day, $this_month, $this_year) = @this_time[3,4,5];
my %series_indexes = ();
foreach my $year (1999 .. $this_year)
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

open ALL, ">$dest_dir/all.html";
print ALL "<html>\n";
print ALL "<head><title>Haifa Linux Club (All Lectures)</title></head>\n";
print ALL "<body bgcolor=\"white\">\n";
print ALL "<div align=\"center\"><h1>Haifa Linux Club - All the Lectures</h1></div>\n";
print ALL "<h2>Past Lectures</h2>\n";
print ALL "<table>\n";
print ALL "<tr>\n";
foreach my $header ("Lecture Number", "Subject", "Lecturer", "Date", "Comments or Links")
{
    print ALL "<td>$header</td>\n";
}
print ALL "</tr>\n";
my ($lecture);
foreach $lecture (@lectures_flat)
{
    my @fields;

    # Generate the lecture number
    my $series = $lecture->{'series'};
    my $idx_in_series = $series_indexes{$series}
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

    push @fields, 
        $lecturer_record->{'subject_render'}->(
            $lecture,
            $idx_in_series
        );

    # Generate the lecturer field

    my $lecturer_field;
    if ($lecturer_record->{'name_render_type'} eq "email")
    {
        $lecturer_field = "<a href=\"mailto:" . $lecturer_record->{'email'} . 
        "\">" . $lecturer_reocrd->{'name'} . "</a>";
    }
    else
    {
        die "Uknown lecturer name_render_type for lecturer '$lecturer_id'";
    }

    push @fields, $lecturer_field;
    
    # Generate the date field
    
    my $date = $lecture->{'d'};

    $date =~ s{^(\d+)/(\d+)/\d{2}(\d{2})$}{$1/$2/$3};
    
    push @fields, $date;

    # Generate the comments field

    push @fields, $lecture->{'comments'};

    foreach my $f (@fields)
    {
        print ALL "<td>\n$f\n</td>\n";
    }
}
continue
{
    $series_indexes{$lecture->{'series'}}++;
}

print ALL "</table>\n";
print ALL "</body>\n";
print ALL "</html>\n";
