#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';
use LWP::UserAgent;

my $res = LWP::UserAgent->new->get('http://nds.nokia.com/uaprof/N6100r100.xml');
diag explain $res;
ok $res->is_success;

__END__
