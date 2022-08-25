#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use Doit;
use Doit::Extcmd qw(is_in_path);
use Doit::Log;
use File::Temp;

my $doit = Doit->init;

my $tmp1 = File::Temp->new;
$tmp1->print(#"x"x1024 . " " .
    "old content");
$tmp1->close;

my $tmp2 = File::Temp->new;
$tmp2->print(#"x"x1024 . " " .
    "new content");
$tmp2->close;

info "diff is_in_path: " . is_in_path("diff");

my($diff, $diff_stderr) = _open3(undef, "diff", "-u", "$tmp1", "$tmp2");
info "diff: $diff";
info "diff_stderr: $diff_stderr";

    sub _open3 {
	my($instr, @args) = @_;
info "before quoting: @args";
	@args = Doit::Win32Util::win32_quote_list(@args) if Doit::IS_WIN;
info "after quoting: @args";

	require IO::Select;
	require IPC::Open3;
	require Symbol;

info "required modules";

	my($chld_out, $chld_in, $chld_err);
	$chld_err = Symbol::gensym();
info "chld_err symbol: $chld_err";
	my $pid = IPC::Open3::open3((defined $instr ? $chld_in : undef), $chld_out, $chld_err, @args);
info "open3 started with pid: $pid";
	if (defined $instr) {
	    print $chld_in $instr;
	    close $chld_in;
info "stdin provided";
	}

	my $sel = IO::Select->new;
	$sel->add($chld_out);
	$sel->add($chld_err);
info "IO::Select on chld_out and _err";

	my %buf = ($chld_out => '', $chld_err => '');
	while(my @ready_fhs = $sel->can_read()) {
info "can_read: @ready_fhs";
	    for my $ready_fh (@ready_fhs) {
		my $buf = '';
info "about to read $ready_fh";
		while (sysread $ready_fh, $buf, 1024, length $buf) {
info "in while-sysread loop, length of buf=" . length($buf);
		}
		if ($buf eq '') { # eof
info "found eof";
		    $sel->remove($ready_fh);
		    $ready_fh->close;
		    last if $sel->count == 0;
		} else {
info "append " . length($buf) . " bytes to buf";
		    $buf{$ready_fh} .= $buf;
		}
	    }
	}
info "waiting for process";
	waitpid $pid, 0;
info "all done";

	($buf{$chld_out}, $buf{$chld_err});
    }

__END__
