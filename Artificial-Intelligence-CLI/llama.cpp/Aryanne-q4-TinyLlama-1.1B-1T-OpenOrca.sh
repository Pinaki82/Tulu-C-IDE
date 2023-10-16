#!/bin/bash

# https://github.com/garyexplains/examples/blob/master/how-to-run-llama-cpp-on-raspberry-pi.md
# https://huggingface.co/TheBloke/Llama-2-7b-Chat-GGUF/tree/main
# https://huggingface.co/TheBloke/CodeLlama-7B-Instruct-GGUF/tree/main

# https://huggingface.co/Aryanne/TinyLlama-1.1B-1T-OpenOrca-gguf
# wget https://huggingface.co/Aryanne/TinyLlama-1.1B-1T-OpenOrca-gguf/resolve/main/q4_0-tinyllama-1.1b-1t-openorca.gguf

cd /home/YOUR_USERNAME/PortablePrograms/llama.cpp \

# Add the following line before the line containing `--ctx_size 2048 \`.
#        -i -r "User:" -f prompts/custom_prompt_template.txt \
./main  -m models/q4_0-tinyllama-1.1b-1t-openorca.gguf --color \

       --ctx_size 2048 \
       -n -1 \
       -ins -b 256 \
       --top_k 10000 \
       --temp 0.2 \
       --repeat_penalty 1.1
