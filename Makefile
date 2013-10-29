all:
	perl -MTk -e '$$mw = tkinit; $$mw->Label(-text => q{Hello, world!})->pack; $$mw->after(1000);'
