@echo on
clang-tidy 1>clang_tidy_output.txt *.cpp *.hpp *.c *.h *.cxx *.hxx
pause
exit
