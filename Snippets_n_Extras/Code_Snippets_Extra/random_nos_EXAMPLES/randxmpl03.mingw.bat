@echo on
cd
cls
bakefile -f mingw -o randxmpl03.mingw.mak randxmpl03.bkl
mingw32-make -f randxmpl03.mingw.mak
cmd
