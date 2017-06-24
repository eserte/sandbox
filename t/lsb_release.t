#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

SKIP: {
    skip "not on linux" if $^O ne 'linux';
    skip "not on travis" if !$ENV{TRAVIS};

    my $linuxcodename = `lsb_release -cs`;
    like $linuxcodename, qr{^(precise|trusty)$}, 'one of the expected ubuntu distributions';
}

__END__
