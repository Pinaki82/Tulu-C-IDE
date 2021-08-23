@echo on
cd
cls
bakefile -f mingw -o randxmpl02.mingw.mak randxmpl02.bkl
mingw32-make -f randxmpl02.mingw.mak
cmd
