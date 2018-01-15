# Test for https://rt.perl.org/Public/Bug/Display.html?id=132648#txn-1524095

use warnings;
use strict;

use File::Temp qw(tempdir);
use Test::More;

plan skip_all => "Only for cygwin" if $^O ne 'cygwin';

my $tmp = tempdir(CLEANUP => 1);
unless(mkdir("$tmp/testdir") && chdir("$tmp/testdir") && rmdir("$tmp/testdir")){
    plan skip_all => "can't be in non-existent directory";
}

if (-e "$tmp/testdir") {
    fail "$tmp/testdir still exists?";
}

diag `pwd`;

pass "...";

chdir "/";
done_testing;
