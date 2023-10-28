#!/bin/bash

# https://github.com/garyexplains/examples/blob/master/how-to-run-llama-cpp-on-raspberry-pi.md
# https://huggingface.co/TheBloke/Llama-2-7b-Chat-GGUF/tree/main
# https://huggingface.co/TheBloke/CodeLlama-7B-Instruct-GGUF/tree/main

# https://huggingface.co/TheBloke/dolphin-2.1-mistral-7B-GGUF/tree/main
# wget https://huggingface.co/TheBloke/dolphin-2.1-mistral-7B-GGUF/resolve/main/dolphin-2.1-mistral-7b.Q2_K.gguf

cd /mnt/hdd/HOME/llama.cpp \

#        -i -r "User:" -f prompts/custom_prompt_template.txt \
./main  -m models/dolphin-2.1-mistral-7b.Q2_K.gguf --color \

       --ctx_size 2048 \
       -n -1 \
       -ins -b 256 \
       --top_k 10000 \
       --temp 0.2 \
       --repeat_penalty 1.1
