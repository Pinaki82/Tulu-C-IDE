@ECHO OFF
REM passing parameters to executable in gdb
REM http://stackoverflow.com/questions/6121094/how-do-i-run-a-program-with-commandline-args-using-gdb-within-a-bash-script
cd
doskey cd=chdir/d $*
gdb --args str_splitter_test.exe "file.txt"
