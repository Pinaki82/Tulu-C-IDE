@echo off
REM -weak -standard -checks -strict
@echo on
splint >splint_output.txt -strict *.c
cmd
