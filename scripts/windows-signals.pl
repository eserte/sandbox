#!/usr/bin/perl

use strict;
use warnings;
use autodie;

my $child_pid = fork;
if ($child_pid == 0) {
    exec($^X, '-e', 'while(){ sleep 1 }');
}

sleep 1;
kill KILL => $child_pid;
waitpid $child_pid, 0;
my $signalnum = $? & 127;
my $coredump = ($? & 128) ? 'with' : 'without';
my $exitcode = $?>>8;
warn "exitcode: $exitcode, $coredump coredump, signal: $signalnum\n";

__END__
