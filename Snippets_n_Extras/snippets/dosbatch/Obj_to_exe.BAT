@echo off
cd
cls
@echo on
gcc -m64 -c -O2 svchost.c
gcc -m64 -o svchost.exe svchost.o -m64 -s -mwindows
cmd
