#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

use MIME::Lite;

use Test::FakeSendmail;

my $tfsm = Test::FakeSendmail->new(maildirectory => "/tmp/tfsm");

MIME::Lite->new(From=>q{me@localhost},To=>q{me@localhost},Data=>"test")->send
    or die;

my @mails = $tfsm->mails;
my $content = $mails[0]->content;
like $content, qr{me\@localhost};
like $content, qr{test};

__END__
