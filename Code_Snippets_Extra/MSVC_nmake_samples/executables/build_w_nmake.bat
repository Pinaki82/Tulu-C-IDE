bakefile -f msvc -o Makefile.mak palin_exe_vc.bkl

call "%programfiles%\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
nmake -f makefile.mak
cmd
