#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More;
plan skip_all => 'deactivated';
__END__

use Test::More 'no_plan';

use_ok 'DB_File';

if (-e "cpanfile") {
    diag `cat cpanfile`;
}

__END__
