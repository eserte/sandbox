use ExtUtils::MakeMaker;
WriteMakefile(NAME => "Sandbox",
	      PREREQ_PM => { 'Test::NoWarnings' => 0 },
             );

#system("env | sort");
