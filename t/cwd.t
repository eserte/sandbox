#!/usr/bin/perl -w

use strict;
use Test::More tests => 2;

use Cwd 'realpath';

ok defined realpath '.';
ok defined realpath 'thispathdoesnotexist';

__END__
