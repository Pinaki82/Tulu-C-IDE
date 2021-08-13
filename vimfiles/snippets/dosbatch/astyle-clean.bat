@color 0B
@echo off

REM copy or move Artistic Style backup files to a backup directory

REM CHANGE THE FOLLOWING 4 VARIABLES
REM indir is the input top level directory containing the .orig files
REM outdir is the output top level directory containing the moved files
REM fileext is the backup file extension
REM copyfiles is COPY or MOVE the files

set indir=%USERPROFILE%\Projects\TestData\CodeBlocks\src
set outdir=%USERPROFILE%\Projects\TestData\CodeBlocks\backup
set fileext=.orig
REM USE ONE OF THE FOLLOWING TO COPY OR MOVE THE FILES
set copyfiles=COPY
:: set copyfiles=MOVE

REM display the variables
echo -
echo %copyfiles% Artistic Style backup files
echo FROM %indir%
echo TO   %outdir%
echo -

REM validate input directory
if not exist "%indir%"  (
	echo Input directory does not exist!
	pause
	exit
)
if /i "%indir%" == "%outdir%" (
	echo Input and output directories are the same!
	pause
	exit
)

REM optional statement to run Artistic Style
:: set progdir=C:\_jpFiles\Projects\AStyle\_VC-2003\bin
:: %progdir%\AStyle.exe   -R  "%indir%\*.cpp"  "%indir%\*.h"
:: if errorlevel 1 pause

REM set inlength to the length of indir
call :SETLENGTH  "%indir%"  inlength
set count=0
REM loop thru the input directory and find the .orig files
REM MOVEIT is called outside the FOR loop so the variables will be resolved
REM arguments must be in quotes to allow spaces in names
for /R  "%indir%"  %%V   in (*%fileext%)  do (
    call  :MOVEIT  "%%~dpV"  "%%~nxV"  "%%V"
)
echo %count% files processed
echo -
pause
goto :EOF


SETLOCAL
REM MOVEIT - move an .orig file to the new directory
REM %1 is the input file path
REM %2 is the input file name and extension
REM %3 is the input file path, name, and extension
:MOVEIT
REM remove quotes and set variables
set inpath=%~1
set nameext=%~2
REM remove indir from the input file path giving the sub path
REM +1 is to remove the trailing "\"
call set /A  length = inlength + 1
call set outsub=%%inpath:~%length%%%
REM prepend sub path to the output path
set outpath=%outdir%\%outsub%
REM create output directory
if not exist "%outpath%"  md "%outpath%"
REM copy or move the files
%copyfiles% %3  "%outpath%"  >  NUL
if errorlevel 1 pause
REM increment the file count
call  set /A  count += 1
REM echo for every 100 files processed
set /A  mod=%count%%%100
if %mod% == 0 echo %count% files processed
goto :EOF
ENDLOCAL


SETLOCAL
REM SETLENGTH - set a variable to the length of a string
REM %1 is the string
REM %2 is the name of the variable to set
:SETLENGTH
REM create a .tmp file in the TEMP folder
set string=%~1
set tempfile=%TEMP%\astyle.tmp
REM write the string to tempfile
REM put redirection symbol right after variable to avoid a trailing space
echo %string%> %tempfile%
REM get the file size in bytes
for %%a in (%tempfile%) do set /a length=%%~za
REM subtract 2 bytes , 1 for CR, 1 for LF
set /a length -= 2
REM set the variable to the length
set %2=%length%
::echo variable "%2" set to %length% characters
REM clean up the temp file
del %tempfile%
ENDLOCAL


:EOF
