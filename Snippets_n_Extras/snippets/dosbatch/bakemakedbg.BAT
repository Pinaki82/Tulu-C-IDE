@echo on
cd
cls
bakefile -f mingw -o Makefile.mak compile.bkl
mingw32-make -f Makefile.mak
gdb a
