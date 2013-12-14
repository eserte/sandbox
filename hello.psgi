# -*- perl -*-

use strict;
use warnings;

use Plack::Builder;

builder {

    enable 'Rewrite', rules => sub {
	if (m{^/$}) {
	    $_ = '/bla';
	    return 301;
	}
    };

    mount '/bla' => sub {
	my $env = shift;
	return [
		'200',
		[ 'Content-Type' => 'text/plain' ],
		[ "Hello World" ], # or IO::Handle-like object
	       ];
    }
};
