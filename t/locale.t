#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More;

plan skip_all => "Only for Windows" if $^O ne 'MSWin32';
plan 'no_plan';

#for my $lc_all (qw(en-US en-US.UTF-8 en_US en_US.UTF-8 de-DE de-DE.UTF-8 de_DE de_DE.UTF-8)) {
for my $lc_all ("English - United States", "English.United States", "English", "German") {
    $ENV{LC_ALL} = $lc_all;
    diag "try LC_ALL=$ENV{LC_ALL}";
    system($^X, "-e", 1);
}

pass "all run!";

__END__
