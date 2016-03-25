#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More;

plan skip_all => 'No locale on Windows'
    if $^O eq 'MSWin32';
plan 'no_plan';

my $locales = `locale -a`;
my $locale = `locale`;

diag "all locales:\n" . $locales;

diag "current locale:\n" . $locale;

pass 'got locale info';

__END__
