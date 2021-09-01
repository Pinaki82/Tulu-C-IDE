#!/bin/bash

# Fire up MSYS2 (x64) shell.
# Type:
# ./check_all_MSYS2.sh
# Press <TAB> for filename completion hints
#             *.cpp *.hpp *.c *.h *.cxx *.hxx

clang-check 2>clang_check.output.txt *.cpp
clang-tidy 1>clang_tidy.output.txt *.cpp
cppcheck 2>cppcheck.output.txt --verbose --enable=all --enable=style --enable=performance --enable=portability --enable=information --enable=unusedFunction --enable=missingInclude --inconclusive --force --suppress=missingIncludeSystem --report-progress  *.cpp
g++ 2>g++_fsyntax-only.output.txt -fsyntax-only -Wall -Wextra *.cpp
gcc 2>gcc_fsyntax-only.output.txt -fsyntax-only -Wall -Wextra *.c
flint++ 1>flint_out.txt -l3 -v -r

