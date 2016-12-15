use ExtUtils::MakeMaker;
WriteMakefile(NAME => "Sandbox",
	      PREREQ_PM => {
		#'Devel::Fail::MakefilePL' => 0, # fails! not!
		#'Acme::CPAN::Testers::UNKNOWN' => 0, # fails! (?) --- enable to force failures
		'Cwd' => 3.62,
		'Test::NoWarnings' => 0,
		'LWP::UserAgent' => 0,
		'LWP::Protocol::https' => 0,
		'XML::LibXML::SAX' => 0, # for UAProf tests
		'XML::Parser' => 0, # for UAProf tests
		'DB_File' => 0, # for UAProf tests
		'File::Share' => 0, # may fail with cpm?
	      },
	      #SKIP => [qw(test)],
             );

#system("env | sort");

sub MY::postamble {
    <<EOF;
#test: parallel-test:

parallel-test:
\t\$(INSTALLSCRIPT)/prove -j4 -lr t/

dmake-test:
	echo \$(SOMETHING)
	-cd subdir && \${PERL} Makefile.PL && \${MAKE} \${.MAKEFLAGS}

EOF
}
