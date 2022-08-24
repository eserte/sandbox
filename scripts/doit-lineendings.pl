#!/usr/bin/perl

use Doit;
use Doit::Log;
use File::Temp;

sub show_file ($;$) {
    my($filename, $msg) = @_;
    info $msg if $msg;
    open my $fh, $filename or die $!;
    while(<$fh>) {
	s/(.)/sprintf("%02x ",ord($1))/egs;
	info "$.: $_";
    }
}

my $d = Doit->init;
my $tmp = File::Temp->new;
my $f = "$tmp";
$tmp->close; # for windows, explicite locking
show_file($f, "empty temp");
info "write_binary returned: " . $d->write_binary($f, qq{first line\nsecond line\n});
show_file($f, "after write binary");
#info "change_file returned: " . $d->change_file($f, { match => qr{^first line}, replace => qq{first line\n\n} });
#info "change_file returned: " . $d->change_file($f, { match => qr{^second line}, replace => qq{\nsecond line} });
open my $fh, $f or die $!;
binmode $fh;
open my $ofh, ">", "$f~" or die $!;
binmode $ofh;
while(<$fh>) {
    print $ofh $_;
    if (/^first line/) {
	print $ofh "\n";
    }
}
close $ofh or die $!;
$d->unlink($f);
$d->rename("$f~", $f);
show_file($f, "after change file");

__END__
