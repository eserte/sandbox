#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use Test::More;
plan skip_all => "Test not active"; exit;

__END__

use strict;
use Test::More 'no_plan';
use HTTP::Response;
use LWP::UserAgent;
use IO::Socket::INET;

my $ua = LWP::UserAgent->new;

my $port = $ENV{TRAVIS} ? "80" : "5001";

{
    my $resp = $ua->get("http://localhost:$port");
    ok $resp->is_success;
    is $resp->decoded_content, 'Hello World';
}

{
    my $resp = $ua->head("http://localhost:$port");
    ok $resp->is_success;
    is $resp->decoded_content, '';
}

{
    my $sock = IO::Socket::INET->new(PeerAddr => "localhost:$port")
	or die $!;
    print $sock "HEAD /bla HTTP/1.0\r\nHost: localhost:$port\r\n\r\n";
    my $in = join '', <$sock>;
    unlike $in, qr{Hello};
}

__END__
