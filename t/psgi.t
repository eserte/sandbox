#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
my $resp = $ua->get("http://localhost");
ok $resp->is_success;
is $resp->decoded_content, 'Hello World';

__END__
