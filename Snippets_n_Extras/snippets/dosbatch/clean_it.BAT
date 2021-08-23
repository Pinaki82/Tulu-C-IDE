@echo on
cd
cls
doskey cd=chdir/d $*

mingw32-make -f Makefile clean
cmd

