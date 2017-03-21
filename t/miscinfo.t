#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

diag `pstree -pal`;
diag `systemctl status`;

pass 'just info...';

__END__
