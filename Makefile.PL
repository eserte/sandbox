use ExtUtils::MakeMaker;
WriteMakefile(NAME => "Sandbox",
	      PREREQ_PM => { 'Test::NoWarnings' => 0, 'LWP::UserAgent' => 0 },
	      SKIP => [qw(test)],
             );

#system("env | sort");

sub MY::postamble {
    <<EOF;
test:
\t\$(INSTALLSCRIPT)/prove -j4 -lr t/

EOF
}
