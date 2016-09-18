#!/usr/bin/perl -w

use strict;
use Test::More tests => 3;

use Cwd 'realpath';

ok  defined realpath '.';
ok  defined realpath 'thispathdoesnotexist';
ok !defined realpath 'thisfolderdoesnotexist/thisfiledoesnotexist';

__END__
