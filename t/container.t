#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

sub is_container {
    my $container = 0;
    if (open my $fh, '<', "/proc/1/cgroup") {
	while(<$fh>) {
	    if (m{^\d+:pids:(.*)} && $1 ne '/init.scope') {
		$container = 1;
		last;
	    }
	}
    }
    $container;
}

diag "Running in container: " . is_container();
pass "Container test finished";

__END__
