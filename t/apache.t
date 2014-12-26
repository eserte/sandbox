#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

#use Test::More;
#plan skip_all => "Not enabled";
#__END__

use strict;
use Test::More 'no_plan';

use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
my $resp = $ua->get("http://localhost");
ok $resp->is_success;
diag $resp->as_string;

__END__
