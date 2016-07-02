#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

$SIG{ALRM} = sub { die "Timeout" };
my $t0 = time;
diag "set alarm";
alarm(1);
diag "sleep for 2 seconds";
eval {
    sleep 2;
};
like $@, qr/Timeout/;
diag "Started $t0, now it's " . time;

__END__
