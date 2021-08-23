@echo on
cd
cls
bakefile -f mingw -o test_ran_storing.mingw.mak test_ran_storing.bkl
mingw32-make -f test_ran_storing.mingw.mak
cmd
