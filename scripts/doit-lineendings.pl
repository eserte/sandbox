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
	print "$_\n";
    }
}

my $d = Doit->init;
my $tmp = File::Temp->new;
my $f = "$tmp";
$tmp->close; # for windows, explicite locking
show_file($f, "empty temp");
info $d->write_binary($f, qq{first line\nsecond line\n});
show_file($f, "after write binary");
#info $d->change_file($f, { match => qr{^first line}, replace => qq{first line\n\n} });
info $d->change_file($f, { match => qr{^second line}, replace => qq{\nsecond line} });
show_file($f, "after change file");

__END__
