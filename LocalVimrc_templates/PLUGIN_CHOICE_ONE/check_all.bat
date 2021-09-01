@echo off
rem       *.cpp *.hpp *.c *.h *.cxx *.hxx
@echo on

clang-check 2>clang_check.output.txt *.cpp

clang-tidy 1>clang_tidy.output.txt *.cpp

cppcheck 2>cppcheck.output.txt --verbose --enable=all --enable=style --enable=performance --enable=portability --enable=information --enable=unusedFunction --enable=missingInclude --inconclusive --force --suppress=missingIncludeSystem --report-progress  *.cpp

g++ 2>g++_fsyntax-only.output.txt -fsyntax-only -Wall -Wextra *.cpp

gcc 2>gcc_fsyntax-only.output.txt -fsyntax-only -Wall -Wextra *.c

flint++ 1>flint_out.txt -l3 -v -r

pause
exit
