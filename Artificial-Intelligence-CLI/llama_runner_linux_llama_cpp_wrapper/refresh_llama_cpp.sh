#!/bin/bash

# cd /mnt/hdd2/llama.cpp

git pull && \
cmake -B build -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS && \
cmake --build build --config Release -j 4 \
