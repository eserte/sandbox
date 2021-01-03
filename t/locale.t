#!/usr/bin/perl -w
# -*- cperl -*-

#
# Author: Slaven Rezic
#

use strict;
use Test::More;

our $DEBUG = 1;

plan 'no_plan';

my @locales;
if ($^O eq 'MSWin32') {
    @locales = ("English_United States.1252", "German_Germany.1252");
} else {
    @locales = qw(en_US.UTF-8 de_DE.UTF-8);
}
for my $lc_all (@locales) {
    $ENV{LC_ALL} = $lc_all;
    $ENV{LC_MESSAGES} = $lc_all;
    diag "try locale $ENV{LC_ALL}";
    diag "got lang: " . get_lang();
    system($^X, "-MPOSIX=setlocale,LC_ALL,LC_MESSAGES", "-E", 'say q{LC_ALL=}.setlocale(LC_ALL); say q{LC_MESSAGES=}.setlocale(LC_MESSAGES);');
}

pass "all run!";

# from Msg.pm
sub get_lang {
    my $lang;
    my %ignore = (C => 1, POSIX => 1);
    for my $env (qw(LC_ALL LC_MESSAGES LANG)) {
	warn "get_lang: try env=$lang";
	if (exists $ENV{$env} && !$ignore{$ENV{$env}}) {
	    $lang = $ENV{$env};
	    warn "get_lang: I am happy with $lang from $env";
	    last;
	}
    }
    if (!defined $lang) {
	# Windows does not know LC_ALL et al, but POSIX::setlocale works
	if (eval { require POSIX; defined &POSIX::setlocale }) {
	    for my $category ('LC_MESSAGES', 'LC_ALL') {
		warn "get_lang: try POSIX::$category";
		if (defined &{"POSIX::$category"}) {
		    $lang = do {
			no strict 'refs';
			POSIX::setlocale(&{"POSIX::$category"});
		    };
		    warn "get_lang: got value $lang";
		    if (defined $lang && $lang ne '') {
			last;
		    }
		}
	    }
	}	
    }
    if (!defined $lang) {
	$lang = "";
    } else {
	# normalize language
			if ($^O eq 'MSWin32') {
			    # normalize
			    if ($lang =~ m{^English_}) {
				$lang = 'en';
			    } elsif ($lang =~ m{^German_}) {
				$lang = 'de';
			    } elsif ($lang =~ m{^French_}) {
				$lang = 'fr';
			    } elsif ($lang =~ m{^Spanish_}) {
				$lang = 'es';
			    } elsif ($lang =~ m{^Croatian_}) {
				$lang = 'hr';
			    } # XXX more?
			}
	$lang =~ s/^([^_.-]+).*/$1/; # XXX better use I18N::LangTags
    }
    if ($DEBUG) {
	warn "Use language $lang\n";
    }
    $lang;
}

__END__
