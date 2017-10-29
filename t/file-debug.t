#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use Doit;
use Doit::Extcmd;
use File::Temp 'tempdir';
use Test::More;

sub slurp ($) { diag "Slurping from $_[0]"; open my $fh, shift or die $!; local $/; <$fh> }
sub slurp_utf8 ($) { open my $fh, shift or die $!; binmode $fh, ':encoding(utf-8)'; local $/; <$fh> }

return 1 if caller;

require FindBin;
{ no warnings 'once'; push @INC, $FindBin::RealBin; }
require TestUtil;

# REPO BEGIN
# REPO NAME strace_begin /home/eserte/src/srezic-repository 
# REPO MD5 67d59559401a50c9c92bfc059d24ba54

=head2 strace_begin(@strace_args)

Run L<strace(1)> on the current process, until the returned object
goes out of scope. Usually used like this:

    {
        my $strace_keeper = strace_begin(qw(-o /tmp/strace.log -f -tt -T -s1024));
        ... hot code ...
    }
    # strace not active anymore

There's a block-like alternative:

    my $result = strace {
        ... hot code ...
    } qw(-o /tmp/strace.log -f -tt -T -s1024));
    # strace not active anymore

Additionally to the options L<strace(1)> accepts, there's also the
option C<--strace-cmd>, which can be used for another command than
C<strace>, but which behaves like C<strace> (i.e. takes the option
C<-p I<pid>>).

=cut

BEGIN {
    my $DESTROY = sub { 
	my $self = shift;
	my $strace_pid = $self->{strace_pid};
	die "Should never happen: no strace_pid in " . ref($self) if !$strace_pid;
	kill INT => $strace_pid;
	waitpid $strace_pid, 0;
    };
    no strict 'refs';
    *{__PACKAGE__.'::Strace_Myself::DESTROY'} = $DESTROY;
}

sub strace_begin (@) {
    my(@strace_args) = @_;
    my $strace_cmd = 'strace';
    {
	require Getopt::Long;
	Getopt::Long::Configure('pass_through');
	local @ARGV = @strace_args;
	Getopt::Long::GetOptions('strace-cmd=s' => \$strace_cmd);
	Getopt::Long::Configure('no_pass_through');
	@strace_args = @ARGV;
    }

    my $pid = $$;
    my $strace_pid = fork;
    if (!defined $strace_pid) {
	warn "Can't run strace: $!";
    } elsif ($strace_pid == 0) {
	my @cmd = (ref $strace_cmd eq 'ARRAY' ? @$strace_cmd : $strace_cmd, '-p', $pid, @strace_args);
	exec @cmd;
	die "@cmd failed: $!";
    }

    bless { strace_pid => $strace_pid }, __PACKAGE__.'::Strace_Myself';
}

sub strace (&;@) {
    my($code, @strace_args) = @_;

    my $strace_keeper = strace_begin(@strace_args);
    $code->();
}
# REPO END

plan 'no_plan';

my $doit = Doit->init;
$doit->add_component('file');

my $tempdir = tempdir('doit_XXXXXXXX', TMPDIR => 1, CLEANUP => 1);
$doit->mkdir("$tempdir/another_tmp");

{
    eval { $doit->file_atomic_write_fh };
    like $@, qr{file parameter is missing}i, "too few params";
}

{
    eval { $doit->file_atomic_write_fh("$tempdir/1st") };
    like $@, qr{code parameter is missing}i, "too few params";
    ok !-e "$tempdir/1st", "file was not created";
}

{
    eval { $doit->file_atomic_write_fh("$tempdir/1st", "not a sub") };
    like $@, qr{code parameter should be an anonymous subroutine or subroutine reference}i, "wrong type";
    ok !-e "$tempdir/1st", "file was not created";
}

{
    eval { $doit->file_atomic_write_fh("$tempdir/1st", sub { }, does_not_exist => 1) };
    like $@, qr{unhandled option}i, "unhandled option error";
    ok !-e "$tempdir/1st", "file was not created";
}

{
    eval { $doit->file_atomic_write_fh("$tempdir/1st", sub { die "something failed" }) };
    like $@, qr{something failed}i, "exception in code";
    ok !-e "$tempdir/1st", "file was not created";
}

{
    $doit->file_atomic_write_fh("$tempdir/1st", sub {
				    my $fh = shift;
				    binmode $fh, ':encoding(utf-8)';
				    print $fh "\x{20ac}uro\n";
				});

    ok -s "$tempdir/1st", 'Created file exists and is non-empty';
    is slurp_utf8("$tempdir/1st"), "\x{20ac}uro\n", 'expected content';
}

{
    $doit->chmod(0600, "$tempdir/1st");
    my $mode_before = (stat("$tempdir/1st"))[2];

    $doit->file_atomic_write_fh("$tempdir/1st", sub {
				    my $fh = shift;
				    print $fh "changed content\n";
				});
    is slurp("$tempdir/1st"), "changed content\n", 'content of existent file changed';
    my $mode_after = (stat("$tempdir/1st"))[2];
    is $mode_after, $mode_before, 'mode was preserved';
}

for my $opt_def (
		 [suffix => '.another_suffix'],
		 [dir => "$tempdir/another_tmp"],
		) {
    my $opt_spec = "@$opt_def";
    $doit->file_atomic_write_fh("$tempdir/1st",
				sub {
				    my $fh = shift;
				    print $fh $opt_spec;
				}, @$opt_def);
    is slurp("$tempdir/1st"), $opt_spec, "atomic write with opts: $opt_spec";
}

SKIP: {
diag -w '/dev/full';
$doit->system(qw(ls -al /dev/full));
    skip "No /dev/full available", 1 if !-w '/dev/full';
diag "Will slurp now";
    my $old_content = slurp("$tempdir/1st");
diag "Slurped, length is " . length($old_content);
    eval { 
	my $strace_keeper = strace_begin(qw(-f -tt -T -s1024));
	sleep 1; # for strace to start
	$doit->file_atomic_write_fh("$tempdir/1st",
				    sub {
					my $fh = shift;
					diag "About to print to fh";
					print $fh "/dev/full testing\n";
					diag "Printing done";
				    }, dir => '/dev/full');
    };
    like $@, qr{Error while closing temporary file}, 'Cannot write to /dev/full as expected';
diag "Will slurp 2 now";
    is slurp("$tempdir/1st"), $old_content, 'content still unchanged';
diag "Everything's done";
}

SKIP: {
    skip "Hangs on travis-ci", 1 if $ENV{TRAVIS}; # reason unknown
    skip "Mounting fs only implemented for linux", 1 if $^O ne 'linux';
    skip "Cannot mount in linux containers", 1 if TestUtil::in_linux_container($doit);
    skip "dd not available", 1 if !Doit::Extcmd::is_in_path("dd");
    skip "mkfs not available", 1 if !-x "/sbin/mkfs";
    my $sudo = TestUtil::get_sudo($doit, info => \my %info);
    skip $info{error}, 1 if !$sudo;

    my $fs_file = "$tempdir/testfs";
    $doit->system(qw(dd if=/dev/zero), "of=$fs_file", qw(count=1 bs=1MB));
    $doit->system(qw(/sbin/mkfs -t ext3), $fs_file);
    my $mnt_point = "$tempdir/testmnt";
    $doit->mkdir($mnt_point);
    $sudo->system(qw(mount -o loop), $fs_file, $mnt_point);
    $sudo->mkdir("$mnt_point/dir");
    $sudo->chown($<, undef, "$mnt_point/dir");

    my $mode_before = (stat("$tempdir/1st"))[2];
    $doit->file_atomic_write_fh("$tempdir/1st",
				sub {
				    my $fh = shift;
				    print $fh "File::Copy::move testing\n";
				}, dir => "$mnt_point/dir");
    is slurp("$tempdir/1st"), "File::Copy::move testing\n", "content OK after using cross-mount move";
    my $mode_after = (stat("$tempdir/1st"))[2];
    is $mode_after, $mode_before, 'mode was preserved';

    $doit->file_atomic_write_fh("$tempdir/fresh",
				sub {
				    my $fh = shift;
				    print $fh "fresh file with File::Copy::move\n";
				}, dir => "$mnt_point/dir");
    is slurp("$tempdir/fresh"), "fresh file with File::Copy::move\n", "cross-mount move with fresh file";

    $sudo->system(qw(umount), $mnt_point);
}

