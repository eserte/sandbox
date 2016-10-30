#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

diag `which wget`;
diag `which curl`;

use_ok 'LWP::Protocol';
use_ok 'LWP::Protocol::https';

__END__
