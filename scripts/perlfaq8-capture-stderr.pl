#!/usr/bin/perl

use strict;
use warnings;
use autodie;

use IPC::Open3;
use File::Spec;

open(NULL, ">", File::Spec->devnull);

{
    no warnings 'once'; # why?
    my $in = \*CHLD_IN;
    my $pid = open3($in, \*PH, ">&NULL", $^X, '-e', 'print scalar(<STDIN>), "\n"');
    print CHLD_IN "non-empty";
    close CHLD_IN;
    while( <PH> ) { warn "got <$_>" }
    waitpid($pid, 0);
    warn $?;
}

__END__

To capture a program's STDERR, but discard its STDOUT:

use IPC::Open3;
use File::Spec;
my $in = '';
my $pid = open3($in, ">&NULL", \*PH, "cmd");
while( <PH> ) { }
waitpid($pid, 0);

To capture a program's STDERR, and let its STDOUT go to our own STDERR:

use IPC::Open3;
my $in = '';
my $pid = open3($in, ">&STDERR", \*PH, "cmd");
while( <PH> ) { }
waitpid($pid, 0);

To read both a command's STDOUT and its STDERR separately, you can redirect them to temp files, let the command run, then read the temp files:

use IPC::Open3;
use IO::File;
my $in = '';
local *CATCHOUT = IO::File->new_tmpfile;
local *CATCHERR = IO::File->new_tmpfile;
my $pid = open3($in, ">&CATCHOUT", ">&CATCHERR", "cmd");
waitpid($pid, 0);
seek $_, 0, 0 for \*CATCHOUT, \*CATCHERR;
while( <CATCHOUT> ) {}
while( <CATCHERR> ) {}

But there's no real need for both to be tempfiles... the following should work just as well, without deadlocking:

use IPC::Open3;
my $in = '';
use IO::File;
local *CATCHERR = IO::File->new_tmpfile;
my $pid = open3($in, \*CATCHOUT, ">&CATCHERR", "cmd");
while( <CATCHOUT> ) {}
waitpid($pid, 0);
seek CATCHERR, 0, 0;
while( <CATCHERR> ) {}

__END__
