@echo on
clang-check 2>clang_check_output.txt *.cpp *.hpp *.c *.h *.cxx *.hxx
pause
exit
