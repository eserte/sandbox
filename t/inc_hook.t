#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

unshift @INC, sub {
    my($code, $filename) = @_;
    warn $filename;
};

diag "requiring something with INC hook";
require File::Spec;
pass "done";

__END__
