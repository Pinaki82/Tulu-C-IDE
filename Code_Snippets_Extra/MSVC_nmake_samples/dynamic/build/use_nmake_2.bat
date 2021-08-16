bakefile -f msvc -o Makefile2.mak use_vc.bkl

call "%programfiles%\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
nmake -f makefile2.mak
cmd
