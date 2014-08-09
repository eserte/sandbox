#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use Test::More;
plan skip_all => "Not enabled";
__END__

use strict;
use Test::More 'no_plan';

#my $cmd = <<'EOF';
#xprop -id $(xprop -root _NET_SUPPORTING_WM_CHECK | perl -nle 'm{#\s+(\S+)} and print $1') _NET_WM_NAME
#EOF
#
#my $wm = `$cmd`;
#diag $wm;
#
#my $dpkg_l = `dpkg -l`;
#diag $dpkg_l;

pass "dummy...";

__END__
