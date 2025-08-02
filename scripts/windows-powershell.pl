#!/usr/bin/env perl
# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 2025 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://www.rezic.de/eserte/
#

# try to choco install gd

use strict;
use warnings;
#use File::Temp;
#
## Create temporary files for stdout and stderr using the OO constructor interface
#my $out_tmp = File::Temp->new(SUFFIX => '.log', UNLINK => 1);
#my $err_tmp = File::Temp->new(SUFFIX => '.log', UNLINK => 1);
#
## Get file names
#my $outfilename = $out_tmp->filename;
#my $errfilename = $err_tmp->filename;
#my $cmd = sprintf q(powershell -NonInteractive -NoProfile -Command "$process = Start-Process 'choco' -PassThru -ErrorAction Stop -ArgumentList 'install -y --debug --verbose --no-progress gd' -Verb RunAs -RedirectStandardOutput '%s' -RedirectStandardError '%s' -Wait; Exit $process.ExitCode"), $outfilename, $errfilename;

use Win32;
if (Win32::IsAdminUser()) {
    print "Running as Administrator\n";
} else {
    print "Not running as Administrator\n";
}

#my $cmd = q(powershell -NonInteractive -NoProfile -Command "$process = Start-Process 'choco' -PassThru -ErrorAction Stop -ArgumentList 'install -y --debug --verbose --no-progress gd' -Verb RunAs -Wait; Exit $process.ExitCode");
#my $cmd = q(powershell -NonInteractive -NoProfile -Command "$process = Start-Process 'choco' -PassThru -ErrorAction Stop -ArgumentList 'install -y --debug --verbose --no-progress gd' -Wait; Exit $process.ExitCode");
my $cmd = 'choco install -y --debug --verbose --no-progress gd';

warn "Will run now:

    $cmd
";
system $cmd;
warn "exit code: $?\n";

#system qq(type "$outfilename" "$errfilename");

system "choco list --localonly --limit-output";


__END__
