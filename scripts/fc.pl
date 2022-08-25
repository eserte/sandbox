#!/usr/bin/perl

use Doit;
use Doit::Log;
use File::Temp;

my $doit = Doit->init;

my $tmp1 = File::Temp->new;
$tmp1->print(#"x"x1024 . " " .
    ("same line\n" x 20) . ("old content\n" . ("same line\n" x 20)) x 2);
$tmp1->close;

my $tmp2 = File::Temp->new;
$tmp2->print(#"x"x1024 . " " .
    ("same line\n" x 20) . ("new content\n" . ("same line\n" x 20)) x 2);
$tmp2->close;

eval { $doit->system("fc", "$tmp1", "$tmp2") };
eval { $doit->system("diff", "-u", "$tmp1", "$tmp2") };
eval { $doit->system("fc", "/h") };

__END__
