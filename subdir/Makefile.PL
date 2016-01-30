use ExtUtils::MakeMaker;

WriteMakefile(NAME => "Dummy");

sub MY::postamble {
<<'EOF';
all::
	echo This is a subdir

EOF
}

