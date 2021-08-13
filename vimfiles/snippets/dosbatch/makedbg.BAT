@echo on
cd
cls
bakefile -f mingw -o Makefile.mak 00001.bkl
mingw32-make -f Makefile.mak
gdb 00001
