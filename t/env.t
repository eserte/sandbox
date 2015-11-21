#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

for my $env (sort keys %ENV) {
    diag "$env = $ENV{$env}";
}

pass 'all done';

__END__
