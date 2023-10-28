@echo off
REM https://superuser.com/questions/225692/why-is-cd-in-windows-not-able-to-switch-between-drives
doskey cd=chdir/d $*
REM Enter the LLaMA program directory
N:
cd N:\llama.cpp\llama-b1-bin-win-avx2-x64

REM https://huggingface.co/TheBloke/dolphin-2.1-mistral-7B-GGUF/tree/main
REM wget https://huggingface.co/TheBloke/dolphin-2.1-mistral-7B-GGUF/resolve/main/dolphin-2.1-mistral-7b.Q2_K.gguf

set LlamaPath=N:\llama.cpp\llama-b1-bin-win-avx2-x64

@echo on

"%LlamaPath%\main.exe" ^
-m models\dolphin-2.1-mistral-7b.Q2_K.gguf ^
--color ^
--ctx_size 2048 ^
-n -1 ^
-ins ^
-b 256 ^
--top_k 10000 ^
--temp 0.2 ^
--repeat_penalty 1.1
