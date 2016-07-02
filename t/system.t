#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

system 'perl', '-e', 'kill 9 => $$'; 

                if ($? == -1) {
                    diag "failed to execute: $!\n";
                }
                elsif ($? & 127) {
                    diag sprintf "child died with signal %d, %s coredump\n",
                        ($? & 127),  ($? & 128) ? 'with' : 'without';
                }
                else {
                    diag sprintf "child exited with value %d\n", $? >> 8;
                }

pass "done system";


__END__
