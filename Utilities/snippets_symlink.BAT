@echo off
rem google; creating a symlink windows
rem http://www.howtogeek.com/howto/16226/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/

rem /D – creates a soft symbolic link, which is similar to a standard folder or file shortcut in Windows.  This is the default option, and mklink will use it if you do not enter a prefix.
rem /H – creates a hard link to a file
rem /J – creates a hard link to a directory or folder
@echo on

rem win7: mklink /J %USERPROFILE%\vimfiles\snippets %USERPROFILE%\.vim\snippets
rem xp: junction -s %USERPROFILE%\vimfiles\snippets %USERPROFILE%\.vim\snippets
cmd

