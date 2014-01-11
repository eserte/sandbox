#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

use MIME::Lite;

my @MIME_Lite_send=();
MIME::Lite->new(From=>q{me@localhost},To=>q{me@localhost},Data=>"test")->send(@MIME_Lite_send)
    or die;

__END__
