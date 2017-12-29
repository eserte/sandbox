#!/usr/bin/perl -w
# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 2017 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://www.rezic.de/eserte/
#

use lib "Doit/lib";
use Doit;
use Doit::Log;
use Doit::Util qw(in_directory);

my $doit = Doit->init;
my $type = shift;
if ($type eq 'cygwin') {
    in_directory {
	$doit->system("c:\\cygwin\\bin\\sh", "-c", "perl Build.PL && perl Build && perl Build test");
    } 'Doit';
} elsif ($type eq 'native') {
    in_directory {
	$doit->system('perl', 'Build.PL');
	$doit->system('perl', 'Build');
	local $ENV{HARNESS_OPTIONS} = 'j4:c';
	$doit->system('perl', 'Build', 'test');
    } 'Doit';
} else {
    error "Unknown type '$type'";
}


__END__
