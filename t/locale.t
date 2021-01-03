#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

for my $lc_all (qw(en-US en-US.UTF-8 en_US en_US.UTF-8 de-DE de-DE.UTF-8 de_DE de_DE.UTF-8)) {
    $ENV{LC_ALL} = $lc_all;
    diag "try LC_ALL=$ENV{LC_ALL}";
    system($^X, "-e", 1);
}

__END__
