package Data;

require Exporter;

use vars qw(@ISA);

@ISA=qw(Exporter);

my @exported_vars = qw(%lecturer_aliases %lecturers %lectures %series_map);

use vars @exported_vars;

use vars qw(@EXPORT);

@EXPORT=(@exported_vars);

%lecturer_aliases = 
(
    'choo' => "guykeren",
    'kilmo' => "orrd",
    'mulix' => "muli"
);

sub series_idx_subject_render
{
    my $lecture = shift;
    my $idx_in_series = shift;
    my $url = exists($lecture->{'url'}) ? $lecture->{'url'} : "$idx_in_series/";
    return "<a href=\"./lectures/$url\">" . $lecture->{'s'} . "</a>";
};

sub no_url_subject_render
{
    my $lecture = shift;

    return $lecture->{'s'};
}

%lecturers = 
(
    'alon' =>
    {
        'name' => "Alon Altman",
        'name_render_type' => "email",
        'email' => "alon\@vipe.technion.ac.il",
        'subject_render' => \&series_idx_subject_render,
    },
    'asaf_arbely' =>
    {
        'name' => "Asaf Arbely",
        'name_render_type' => "plain",
        'subject_render' => \&series_idx_subject_render,
    },
    'guykeren' =>
    {
        'name' => "Guy Keren",
        'name_render_type' => "email",
        'email' => "choo\@actcom.co.il",
        'subject_render' => \&series_idx_subject_render,
    },
    'oded_koren' =>
    {
        'name' => "Oded Koren",
        'name_render_type' => "plain",
        'subject_render' => \&no_url_subject_render,
    },       
    'orrd' =>
    {
        'name' => "Orr Dunkelman",
        'name_render_type' => "email",
        'email' => "orrd\@vipe.technion.ac.il",
        'subject_render' => \&series_idx_subject_render,
    },
    'shlomif' =>
    {
        'name' => "Shlomi Fish",
        'name_render_type' => "email",
        'email' => "shlomif\@vipe.technion.ac.il",
        'subject_render' => sub {
            my $lecture = shift;
            return "<a href=\"http://vipe.technion.ac.il/~shlomif/lecture/" . $lecture->{'url'} . "\">" . $lecture->{'s'} . "</a>";
        },
    },
);

%series_map =
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

my %topics = 
(
    'advocacy' =>
    {
        'name' => "Advocacy and Evangelism lectures",
    },
    'net' => 
    {
        'name' => "Networking lectures",        
    },
    'kernel' =>
    {
        'name' => "Linux kernel lectures",
    },
    'security' =>
    {
        'name' => "Security lectures",
    },
    'prog' =>
    {
        'name' => "Programming related lectures",
    },
    'tools' =>
    {
        'name' => "Tools and utilities lectures",
    },
);

%lectures = 
(
    '1999' =>
    [
        {
            'l' => "choo",
            's' => "Introduction to Linux",
            'd' => "19/8",
            't' => "none",
        },
        {
            'l' => "choo",
            's' => "Robust Programming",
            'd' => "9/9",
            't' => "prog",
        },
        {
            'l' => "choo",
            's' => "PAM (Pluggable Authentication Management)",
            'd' => "23/9",
            't' => "security",
        },
        {
            'l' => "orrd",
            's' => "Linux Security",
            'd' => "21/10",
            't' => "security",
        },
        {
            'l' => "choo",
            's' => "PAM (Pluggable Authentication Management) - Writing PAM Modules",
            'd' => "4/11",
            't' => "security",
            'comments' => qq{<ul>
	 <li><a href="http://www.csn.ul.ie/~airlied/pam_smb">A PAM Module
for NT Connectivity</a>
	 <li><a href="http://us1.samba.org/samba/ftp/pam_ntdom">A Samba
Based PAM</a>
      </ul>},      
        },
        {
            'l' => "asaf_arbely",
            's' => "Universal Servers - Architecture, Availability and Usage. The plaftorm is... Informix",
            'd' => "18/11",
            't' => "tools",
            'comments' => <<'EOF',
        <ul>
	 <li><a href="http://www.informix.com/iif2000/">Informix Internet
Foundation 2000</a></li>
         <li><a
href="http://www.informix.com/informix/products/linux/">Informix on
Linux</a></li>
         <li><a href="http://www.informix.com/idn">Informix Developers
Network</a></li>
	 <li><a
href="http://www.informix.com/informix/press/1999/nov99/redhat.htm">Informix
and RedHat</a></li>
       </ul>
EOF
                ,
        },
        {
            'l' => "choo",
            's' => "Introduction to Sockets Programming",
            'd' => "28/11",
            't' => "prog",
            'comments' => qq{Based on <a href="http://www.actcom.co.il/~choo/lupg/tutorials/internetworking/internet-theory.html">LUPG's internet programming tutorial</a>},
        },
        {
            'l' => "oded_koren",
            's' => "Introducing the Linux World to Outsides",
            'd' => "12/12",
            't' => "advocacy",
        },
        {
            'l' => "choo",
            's' => "Advanced Socket Programming",
            'd' => "26/12",
            't' => "prog",
            'comments' => qq{Based on <a href="http://www.actcom.co.il/~choo/lupg/tutorials/internetworking/internet-theory.html">LUPG's internet programming tutorial<br />
    <ul>
	<li><a href="http://www.acme.com/software/mini_httpd/">Mini-httpd,
httpd using the fork model</a></li>
	<li><a href="http://mathop.diva.nl">Mathopd, single process,
single thread, httpd</a></li>
    </ul>
            },
        },  
    ],
    '2000' =>
    [
        {
            'l' => "orrd",
            's' => "Advanced Real Life Administration",
            'd' => "24/7",
            't' => "security",
        },
        {
            'l' => "choo",
            's' => "Kernel Hacking",
            'd' => "7/8",
            't' => "kernel",
        },
        {
            'l' => "choo",
            's' => "CORBA - Theory before Practice",
            'd' => "24/8",
            't' => "prog",
        },
        {
            'l' => "shlomif",
            's' => "Intro to Programming in Perl",
            'd' => "26/3",
            'series' => "perl",
            't' => "prog",
            'url' => "Perl/Newbies/lecture1/",
        },
    ],
    '2001' =>
    [
    ],
    '2002' =>
    [
    ],
);
