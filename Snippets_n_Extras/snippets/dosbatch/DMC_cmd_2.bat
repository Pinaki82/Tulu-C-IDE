@echo off
cd
cls
@echo on
set path=c:\dm\bin;%path%;
dmc -W- -A -H -s -o -O -IC:\dm\stlport\stlport -IC:\dm\include PC_Virus.c

@echo off
cmd
