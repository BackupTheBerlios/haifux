package Data;

require Exporter;

use vars qw(@ISA);

@ISA=qw(Exporter);

my @exported_vars = qw(%lecturer_aliases %lecturers);

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
