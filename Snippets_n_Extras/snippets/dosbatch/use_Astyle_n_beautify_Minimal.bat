@echo off
REM The following options have been added.
REM These options can work only with Artistic Style Version 2.05.1
REM Bracket Modify Options -xn -xc -xl 
REM Indentation Options -xW
REM Formatting Options -xp
@echo on
cd
cls
astyle --recursive --suffix=none --style=java --indent=spaces=2 --attach-namespaces --attach-classes --attach-inlines --attach-extern-c --attach-closing-while --indent-classes --indent-switches --indent-cases --indent-namespaces --indent-continuation=4 --indent-labels --indent-preproc-block --indent-preproc-define --indent-col1-comments --min-conditional-indent=1 --max-continuation-indent=70 --break-blocks=all --pad-oper --pad-comma --unpad-paren --delete-empty-lines --align-pointer=name --align-reference=name --break-closing-braces --break-one-line-headers --add-braces --attach-return-type --attach-return-type-decl --keep-one-line-statements --convert-tabs --remove-comment-prefix --break-after-logical --mode=c --verbose *.cpp *.h *.c *.hpp *.ino *.pde *.cxx *.hxx *.cc *.hh
REM cmd

