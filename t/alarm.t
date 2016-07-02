#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';
use Time::HiRes 'time';

$SIG{ALRM} = sub { die "Timeout" };
my $t0;

$t0 = time;
diag "set alarm";
alarm(1);
diag "sleep for 2 seconds";
eval {
    sleep 2;
};
like $@, qr/Timeout/;
diag "Delta " . (time - $t0);

$t0 = time;
diag "set floating point alarm";
Time::HiRes::alarm(1.3);
diag "sleep for 2 seconds";
eval {
    sleep 2;
};
like $@, qr/Timeout/;
diag "Delta " . (time - $t0);

__END__
