@echo on
cd
cls
bakefile -f dmars -o shuffle_test.dmc.mak shuffle_test.bkl
make -f shuffle_test.dmc.mak
cmd
