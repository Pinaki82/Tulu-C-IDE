#!/bin/bash

# https://github.com/garyexplains/examples/blob/master/how-to-run-llama-cpp-on-raspberry-pi.md
# https://huggingface.co/TheBloke/Llama-2-7b-Chat-GGUF/tree/main
# https://huggingface.co/TheBloke/CodeLlama-7B-Instruct-GGUF/tree/main

# https://huggingface.co/Aryanne/Wizard-Orca-3B-gguf
# https://huggingface.co/Aryanne/Wizard-Orca-3B-gguf/tree/main

cd /home/YOUR_USERNAME/PortablePrograms/llama.cpp \

./main  -m models/q4_0-wizard-orca-3b.gguf --color \
       --ctx_size 2048 \
       -n -1 \
       -ins -b 256 \
       --top_k 10000 \
       --temp 0.2 \
       --repeat_penalty 1.1
