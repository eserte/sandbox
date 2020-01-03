#!/usr/bin/perl -w

use strict;
use Test::More tests => 2;

use Cwd 'realpath';

ok  defined realpath '.';

{
    local $TODO = "Known problem on Windows" if $^O eq 'MSWin32' && $Cwd::VERSION <= 3.54;
    ok  defined realpath 'thispathdoesnotexist'
	or diag "Maybe a known issue: https://rt.cpan.org/Ticket/Display.html?id=117944";
}

__END__
