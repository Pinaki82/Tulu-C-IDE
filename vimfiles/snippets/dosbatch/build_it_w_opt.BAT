@echo on
cd
cls
doskey cd=chdir/d $*

bakefile -f mingw -o Makefile splitter_mk_gen_opt.bkl
mingw32-make -f Makefile 2>build_log.txt
cmd

