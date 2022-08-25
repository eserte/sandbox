#!/usr/bin/perl

use strict;
use warnings;
use autodie;

#use File::Temp;
#my $script = File::Temp->new;
#$script->print(<<"EOF" . <<'EOF');
##!$^X
#EOF
#warn "sub process started...\n";
#while() { sleep 1 }
#EOF
#$script->close;

my $child_pid = fork;
if ($child_pid == 0) {
    #my @cmd = ($^X, '-e', 'warn "sub process started...\n"; while(){ sleep 1 }');
    #my @cmd = ($^X, "$script");
    #warn "Run @cmd...\n";
    #exec(@cmd);
    warn "sub process started...\n";
    while() { sleep 1 }
    exit; # never reached
}

sleep 2;
warn "about to kill sub process in parent...\n";
kill KILL => $child_pid;
waitpid $child_pid, 0;
my $signalnum = $? & 127;
my $coredump = ($? & 128) ? 'with' : 'without';
my $exitcode = $?>>8;
warn "raw \$?: $? (" . sprintf("%016b", $?) . "), exitcode: $exitcode, $coredump coredump, signal: $signalnum\n";

__END__
