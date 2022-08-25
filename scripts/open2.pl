#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use Test::More;

plan 'no_plan';

use Doit;
use Doit::Log;

    sub Doit::_open2 {
	my($instr, @args) = @_;
	info "args before: @args";
	@args = Doit::Win32Util::win32_quote_list(@args) if Doit::IS_WIN;
	info "args after: @args";

	require IPC::Open2;

	my($chld_out, $chld_in);
	info "before calling open2";
	my $pid = IPC::Open2::open2($chld_out, $chld_in, @args);
	info "pid is $pid";
	print $chld_in $instr;
	info "after providing instr";
	close $chld_in;
	info "after closing STDIN";
	local $/;
	info "before slurping STDOUT";
	my $buf = <$chld_out>;
	info "read ". length($buf) . " bytes";
	close $chld_out;
	info "closing STDOUT";
	waitpid $pid, 0;
	info "waitpid was successful --- exitcode is $?";

	$buf;
    }

my $KILL = 9;
my $KILLrx = qr{$KILL};

TODO: {
#    todo_skip "Hangs on Windows, need to check why", 1 if $^O eq 'MSWin32';

my $EOL = $^O eq 'MSWin32' ? "\r\n" : "\n";

{
    my $r = Doit->init;

#    is $r->open2($^X, '-e', 'print scalar <STDIN>'), "", 'no instr -> empty input';

    is $r->open2({instr=>"some input${EOL}"}, $^X, '-e', 'print scalar <STDIN>'), "some input${EOL}", 'expected single-line result';

    is $r->open2({instr=>"first line${EOL}second line${EOL}"}, $^X, '-e', 'print scalar <STDIN>'), "first line${EOL}", 'multi-line input, single-line read';

#    is $r->open2({instr=>"first line${EOL}second line${EOL}"}, $^X, '-e', 'print join "", <STDIN>'), "first line${EOL}second line${EOL}", 'expected multi-line result';

    if (0) { # seems to kill also the test script
#    eval { $r->open2($^X, '-e', 'kill TERM => $$') };
    eval { $r->open2($^X, '-e', 'kill INT => $$') };
    like $@, qr{^Command died with signal 2, without coredump};
    is $@->{signalnum}, 2;
    is $@->{coredump}, 'without';
    }

    eval { $r->open2($^X, '-e', 'kill KILL => $$') };
    like $@, qr{^Command died with signal $KILLrx, without coredump};
    is $@->{signalnum}, $KILL;
    is $@->{coredump}, 'without';

    is $r->open2({quiet=>1}, $^X, '-e', '#nothing'), '', 'nothing returned; command is also quiet';

    is $r->info_open2($^X, '-e', 'print 42'), 42, 'info_open2 behaves as open2 in non-dry-run mode';

    ok !eval { $r->info_open2($^X, '-e', 'exit 1'); 1 };
    like $@, qr{open2 command '.* -e exit 1' failed: Command exited with exit code 1 at .* line \d+}, 'verbose error message with failed info_open2 command';
}

{
    local @ARGV = ('--dry-run');
    my $dry_run = Doit->init;
    is $dry_run->open2({instr=>"input"}, $^X, '-e', 'print scalar <STDIN>'), undef, 'no output in dry-run mode';
    is $dry_run->open2({instr=>"input",info=>1}, $^X, '-e', 'print scalar <STDIN>'), "input", 'info=>1: there is output in dry-run mode';
    is $dry_run->info_open2({instr=>"input"}, $^X, '-e', 'print scalar <STDIN>'), "input", 'info_open2 behaves like info=>1';
}

} # TODO

__END__
