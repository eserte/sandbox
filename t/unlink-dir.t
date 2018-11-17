#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

# test case for
# https://github.com/CpanelInc/Test-MockFile/issues/20

use strict;
use Test::More 'no_plan';

use File::Temp 'tempdir';
use Errno 'EISDIR';

my $t = tempdir( CLEANUP => 1 );
unlink $t;
is $!+0, EISDIR;
diag "Perl $]";

__END__
