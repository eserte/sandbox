#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More 'no_plan';

my $s = 'Image: "i/test-with-gpspos.jpg" (2016-01-01T13:34:45) (delta=0:00) (53.5/13.5)	IMG:t/c6027f6e4c453986a7ad01584faf85cc.jpg 14665,121811
# /tmp/geocode_images_test_1_qVJapR7_/i/nonphoto.txt is too fresh, maybe it can be geocoded later
Image: "i/test-without-gpspos.jpg" (2016-01-02T13:34:45) (delta=0:00) (51/13)	IMG:t/a6aac379ee0e4dc274797b0bbdab96df.jpg -13609,-156840
# Image: "i/unmappable-image.jpg" (not geocodable)
Image: "i/n7650.jpg" (2003-09-24T12:38:55) (delta=0:00) (51.2/13.2)	IMG:t/a2d3eb7ba0137e4657fcd3e00fa77933.jpg -471,-134354
Image: "i/newtest-with-gpspos.jpg" (2016-01-03T13:34:45) (delta=0:00) (52.5/12.5)	IMG:t/332e721ae63f631aa00311470e77445e.jpg -51027,9379
# Image: "i/image-without-date.jpg" (not geocodable)
';

my $qr = qr{(?m-xis:^Image: "(?-xism:)i\/test\-without\-gpspos\.jpg\"\ \(2016\-01\-02T13\:34\:45\)\ \(delta\=0\:00\)\ \(51\/13\)\	IMG\:(?-xism:)t\/.*\.jpg\ \-13609\,\-156840$)};

like $s, $qr;

__END__
