@echo on
cd
cls
bakefile -f dmars -o test_ran_storing.dmc.mak test_ran_storing.bkl
make -f test_ran_storing.dmc.mak
cmd
