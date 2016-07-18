#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More;
use Time::HiRes 'time';

plan skip_all => 'NOT ACTIVE';

plan 'no_plan';

$SIG{ALRM} = sub { die "Timeout" };
my $t0;

$t0 = time;
diag "set alarm";
my $ret = alarm(1);
ok defined $ret;
is $ret, 0;
diag "sleep for 2 seconds";
eval {
    sleep 2;
};
like $@, qr/Timeout/;
diag "Delta " . (time - $t0);

SKIP: {
    skip "unimplemented", 1
	if $^O eq 'MSWin32';
    $t0 = time;
    diag "set floating point alarm";
    Time::HiRes::alarm(1.3);
    diag "sleep for 2 seconds";
    eval {
	sleep 2;
    };
    like $@, qr/Timeout/;
    diag "Delta " . (time - $t0);
}

{
    local $TODO;
    $TODO = "Known to fail on Windows" if $^O eq 'MSWin32';
    alarm(1000);
    my $got = alarm(1000);
    cmp_ok $got, ">", 900;
}

__END__
