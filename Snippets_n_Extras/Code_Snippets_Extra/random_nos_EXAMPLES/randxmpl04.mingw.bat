@echo on
cd
cls
bakefile -f mingw -o randxmpl04.mingw.mak randxmpl04.bkl
mingw32-make -f randxmpl04.mingw.mak
cmd
