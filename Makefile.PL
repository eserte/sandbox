use ExtUtils::MakeMaker;
WriteMakefile(NAME => "Sandbox",
	      PREREQ_PM => { 'Test::NoWarnings' => 0 },
	      SKIP => [qw(test)],
             );

#system("env | sort");

sub MY::postamble {
    <<EOF;
test:
\t\$(INSTALLSCRIPT)/prove -lr t/

EOF
}
