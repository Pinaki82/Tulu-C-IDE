@echo on
cd
cls
bakefile -f mingw/dmars/msvc/..etc.. -o Makefile.mak inputbakefile.bkl
mingw32-make/make/nmake..etc.. -f Makefile.mak
cmd
