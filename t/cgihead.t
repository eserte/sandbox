#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';
use LWP::UserAgent;

my $url = 'https://github.com/eserte/bbbike/archive/master.zip';
my $ua = LWP::UserAgent->new;
my $resp = $ua->get($url);
ok $resp->is_success;
#my $content = $resp->decoded_content;
#$content = substr($content, 0, 2048) if length $content > 2048;
#diag $content;
diag $resp->headers->as_string;

__END__
