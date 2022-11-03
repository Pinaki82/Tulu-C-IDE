@echo off
setlocal

c:/msys64/usr/bin/bash.exe --login -i

REM Access MSYS2 from terminal emulators
REM other than the default Mintty, e.g.,
REM WezTerm, CMD, "AlacrittyTerm", etc.
REM NOTE: Some features may not be available.

REM Keep this file in
REM C:\msys64
REM alongside
REM msys2.exe.

REM https://github.com/microsoft/terminal/issues/1669

REM WINDOWS+r -> systempropertiesadvanced ->
REM -> Environment Variables ->
REM -> System Variables -> Path -> Edit -> New

REM Or, (shortcut): WINDOWS+r -> rundll32.exe sysdm.cpl,EditEnvironmentVariables

REM Add to PATH:

REM C:\msys64\home\AppuRaja\bin;
REM C:\msys64\usr\bin;
REM C:\msys64\usr\x86_64-pc-msys\bin;
REM C:\msys64;
REM C:\msys64\mingw64\bin;
REM C:\msys64\opt\node-v16.16.0-win-x64;

REM Also, add
REM C:\Users\AppuRaja\.cargo\bin;
REM for accessing cargo package builds.

REM Type
REM PATH
REM to see the directories in your PATH Environment Variables.

REM Use: Type
REM msysb.cmd
REM Hit Enter
