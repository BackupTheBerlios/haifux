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
        push @lectures_flat, {%lecture_copy };
    }
    continue
    {
        $lect_idx++;
    }
}

my $dest_dir = "./dest/";
open ALL, ">$dest_dir/all.html";
foreach my $lecture (@lectures_flat)
{
    
}

