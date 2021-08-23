@echo off
REM https://linux.die.net/man/1/cppcheck
@echo on
cppcheck 2>cppcheck_output.txt --verbose --enable=all --enable=style --enable=performance --enable=portability --enable=information --enable=unusedFunction --enable=missingInclude --inconclusive --force --suppress=missingIncludeSystem --report-progress *.cpp *.hpp
cmd
