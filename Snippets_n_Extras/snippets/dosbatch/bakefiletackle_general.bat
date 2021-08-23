bakefile -f msvc -o Makefile.mak ur_bakefile.bkl

call C:\PROGRA~1\MICROS~1.0\VC\vcvarsall.bat
nmake 1>out.txt -f Makefile.mak
cmd


@echo off

rem bakefile -f mingw -o Makefile.mak ur_bakefile.bkl
rem @echo off
rem rem mingw32-make 1>out1.txt -f Makefile.mak pch
rem @echo on
rem mingw32-make 1>out2.txt -f Makefile.mak DEBUG=1
rem cmd

rem static lib
rem bakefile -f mingw -o Makefile.mak ur_bakefile.bkl
rem @echo off
rem rem mingw32-make 1>out1.txt -f Makefile.mak pch
rem @echo on
rem mingw32-make 1>out2.txt 2>out3.txt -f Makefile.mak
rem cmd


rem bakefile -f dmars -o Makefile.mak ur_bakefile.bkl
rem make 1>out.txt -f Makefile.mak DEBUG=1
rem cmd

