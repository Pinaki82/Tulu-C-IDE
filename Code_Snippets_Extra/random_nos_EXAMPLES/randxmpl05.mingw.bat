@echo on
cd
cls
bakefile -f mingw -o randxmpl05.mingw.mak randxmpl05.bkl
mingw32-make -f randxmpl05.mingw.mak
cmd
