#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

my $cmd = <<'EOF';
xprop -id $(xprop -root _NET_SUPPORTING_WM_CHECK | perl -nle 'm{#\s+(\S+)} and print $1') _NET_WM_NAME
EOF

my $wm = `$cmd`;
diag $wm;

pass "dummy...";

__END__
