package Data;

require Exporter;

use vars qw(@ISA);

@ISA=qw(Exporter);

my @exported_vars = qw(%lecturer_aliases %lecturers %lectures);

use vars @exported_vars;

use vars qw(@EXPORT);

@EXPORT=(@exported_vars);

%lecturer_aliases = 
(
    'choo' => "guykeren",
    'kilmo' => "orrd",
    'mulix' => "muli"
);

%lecturers = 
(
    'alon' =>
    {
        'name' => "Alon Altman",
        'render_type' => "alon",
        'email' => "alon\@vipe.technion.ac.il",
    }
    'guykeren' =>
    {
        'name' => "Guy Keren",
        'render_type' => "email",
        'email' => "choo\@actcom.co.il",
    },
    'orrd' =>
    {
        'name' => "Orr Dunkelman",
        'render_type' => "email",
        'email' => "orrd\@vipe.technion.ac.il",
    },
    'shlomif' =>
    {
        'name' => "Shlomi Fish",
        'render_type' => "email",
        'email' => "shlomif\@vipe.technion.ac.il",
    },
);

my %series =
(
    'default' => 
    {
        'lecture_num_template' => 
            sub {
                my $lecture_num = shift;
                return "<div align=\"center\">$lecture_num</div>\n";
            },               
    },
    'perl' =>
    {
        'lecture_num_template' =>
            sub {
                my $lecture_num = shift;
                return "<a href=\"http://vipe.technion.ac.il/~shlomif/lecture/Perl/Newbies/\">Programming in Perl - $lecture_num</a>";
            },        
    },
);

%lectures = 
(
    '1999' =>
    [        
    ],
    '2000' =>
    [
        {
            'l' => "orrd",
            's' => "Advanced Real Life Administration",
            'd' => "24/7",
        },
        {
            'l' => "choo",
            's' => "Kernel Hacking",
            'd' => "7/8",
        },
        {
            'l' => "choo",
            's' => "CORBA - Theory before Practice"
            'd' => "24/8",
        },
        {
            'l' => "shlomif",
            's' => "Intro to Programming in Perl",
            'd' => "26/3",
            'series' => "perl",
        },
    ],
    '2001' =>
    [
    ],
    '2002' =>
    [
    ],
);
