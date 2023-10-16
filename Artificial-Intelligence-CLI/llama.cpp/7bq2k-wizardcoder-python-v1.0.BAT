@echo off
REM https://superuser.com/questions/225692/why-is-cd-in-windows-not-able-to-switch-between-drives
doskey cd=chdir/d $*
REM Enter the LLaMA program directory
N:
cd N:\llama.cpp\llama-b1-bin-win-avx2-x64

REM Set the path to the LLaMA program directory
set LlamaPath=N:\llama.cpp\llama-b1-bin-win-avx2-x64

REM Add the following line before the line containing `--ctx_size 2048  ^`.
REM -i -r "User:" -f prompts/custom_prompt_template.txt  ^

@echo on

"%LlamaPath%\main.exe" ^
-m models\wizardcoder-python-7b-v1.0.Q2_K.gguf ^
--color ^
--ctx_size 2048 ^
-n -1 ^
-ins ^
-b 256 ^
--top_k 10000 ^
--temp 0.2 ^
--repeat_penalty 1.1
