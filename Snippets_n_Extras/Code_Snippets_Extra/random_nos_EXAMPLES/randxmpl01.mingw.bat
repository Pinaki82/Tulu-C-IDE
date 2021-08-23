@echo on
cd
cls
bakefile -f mingw -o randxmpl01.mingw.mak randxmpl01.bkl
mingw32-make -f randxmpl01.mingw.mak
cmd
