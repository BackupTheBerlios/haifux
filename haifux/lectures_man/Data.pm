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
    'shimon_panfil' =>
    {
        'name' => "Shimon Panfil, Ph.D.",
        'name_render_type' => "plain",
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
            's' => "Kerberos Authentication Protocol",
            'd' => "9/1",
            't' => "security",
            'comments' => qq{
<ul>
	<li><a href="ftp://ftp.isi.edu/in-notes/rfc1411.txt">RFC 1411
(Kerberos 4)</a></li>
	<li><a href="ftp://ftp.isi.edu/in-notes/rfc1510.txt">RFC 1510
(Kerberos 5)</a></li>
	<li><a href="http://ptolemy.eecs.berkeley.edu/~cxh/krb/">Kerberos
Data (User, Administrator, etc.)</a></li>
	<li><a href="http://www.cs.technion.ac.il/~cs236350">Computer
Security Course at the Technion</a></li>
	<li><a href="lecture/10/kerberos.ps">Kerberos Version 4 short
explanation (NOT an RFC)</a></li>
       </ul>
    },
        },
        {
            'l' => "shimon_panfil",
            's' => "High Performance Computing on Linux",
            'd' => "23/1",
            't' => "none",
            'comments' => qq{
                <ul>
	<li><a href="http://www.cs.huji.ac.il/labs/mosix">MOSIX (Made in
Israel)</a></li>
	<li><a href="http://www.pobox.com/~kragen/beowulf-faq.txt">
BeoWulf FAQ</a></li>
       </ul>
            },
            'url' => "11/hpcl.ps",
        },
        {
            'l' => "choo",
            's' => "Linux Startup Process - from Boot till SysV Init",
            'd' => "6/2",
            't' => "kernel",
            'comments' => qq{<a href="http://193.6.40.1/~cellux/pc-guide/mbr_asm_eng.html">Contents of a Master Boot Record</a>},            
        },
        {
            'l' => "choo",
            's' => "Linux Runtime Environment",
            'd' => "5/3",
            't' => "prog",
            'comments' => qq{<ul>
	<li><a
href="http://gazette.euskal-linux.org/issue23/flower/page1.html">Processes
on Linux and Windows NT</a></li>
	<li><a
href="http://www.erlenstar.demon.co.uk/unix/faq_2.html">Unix Programming
FAQ - Process control</a></li>
       </ul>},
        },
        {
            'l' => "shlomif",
            's' => "The PostgreSQL Relational Database Server",
            'd' => "2/4",
            't' => "tools",
            'url' => "PostgreSQL-Lecture/",
        },
        {
            'l' => "orrd",
            's' => "The Page Daemon",
            'd' => "16/4",
            't' => "kernel",
            'comments' => qq{
      <ul>
	<li><a href =
"http://www.cs.technion.ac.il/Courses/Operating-Systems-Structure">Operating
systems structure course</a></li>
	<li>Kernel Code - shm.*, mem*.[c,h], ptable*.[c,h,asm] :)</li>
	<li><a href=
"http://www.bell-labs.com/topic/books/os-book/slide-dir/slide-ps.html">Operating
System Concepts</a> chapters 21, 22.</li>
       </ul>
            },
            'subject_render' => \&no_url_subject_render,
        },
        {
            'l' => "choo",
            's' => "Network Protocols (routing, etc)",
            'd' => "7/5",
            't' => "network",
            'url' => "16+18/index.html",
        },
        {
            'l' => "shlomif",
            's' => "The Scheme Programming Language and Lambda Calculus",
            'd' => "28/5",
            't' => "prog",
            'url' => "Lambda-Calculus/",
        },
        {
            'l' => "choo",
            's' => "Network Protocols pt. II - Routing and Higher Level Protocols",
            'd' => "11/6",
            't' => "network",
            'url' => "16+18/index2.html",
            'comments' => qq{<a href="http://rfc.roxen.com/rfc/rfc1771.html">RFC 1771 - BGP 4 protocol</a>},
        },
        {
            'l' => "choo",
            's' => "Advnaced Networking Administration",
            'd' => "25/6",
            't' => "network",
        },
        {
            'l' => "orrd",
            's' => "Introduction to Real Life Administration",
            'd' => "9/7",
            't' => "security",
        },
        {
            'l' => "orrd",
            's' => "Advanced Real Life Administration",
            'd' => "24/7",
            't' => "security",
            'url' => "21/2nd-admin.ps",
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
            'comments' => qq{
<ul>
	<li><a href="http://www.cs.wustl.edu/~schmidt/TAO.html">TAO - The
ACE Orb</a></li>
	<li><a href="http://www.icsi.berkeley.edu/~mico">MICO - Mico Is
COrba</a></li>
      </ul>
            },            
        },
        {
            'l' => "orrd",
            's' => "SED - The Stream Editor",
            'd' => "11/9",
            't' => "tools",
            'comments' => qq{<a href ="http://www.dbnet.ece.ntua.gr/~george/sed/sedtut_1.html">Do it with SED</a>},
        },
        {
            'l' => "choo",
            's' => "CORBA Programming - Simple Clients and Servers",
            'd' => "25/9",
            't' => "prog",
            'comments' => qq{<a href="http://www.cuj.com/experts/1811/vinoski.html">_var and _ptr</a>},
        },
    ],
    '2001' =>
    [
        {
            'l' => "shlomif",
            's' => "Intro to Programming in Perl",
            'd' => "26/3",
            'series' => "perl",
            't' => "prog",
            'url' => "Perl/Newbies/lecture1/",
        },    
    ],
    '2002' =>
    [
    ],
);
