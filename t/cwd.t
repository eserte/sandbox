#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More;

use Cwd 'realpath';

ok defined realpath '.';
{
    my $nonexistent = 'thispathdoesnotexist';
    ok defined realpath $nonexistent;
}

done_testing;

__END__
