#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
my $resp = $ua->get("https://github.com/eserte/bbbike/archive/master.zip", ':content_file' => "/tmp/master.zip");
ok $resp->is_success;
diag $resp->headers->as_string;
system("ls -al /tmp/master.zip");

__END__
