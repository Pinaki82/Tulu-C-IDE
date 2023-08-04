#!/bin/bash

pacman -Syu && \
pacman -Syu && \
pacman -Su && \
# pacman -S pkgfile
# pacman -S reflex
# pacman -S texinfo
# pacman -S texinfo-tex
# pacman -S mingw-w64-x86_64-fd
# pacman -S mingw-w64-x86_64-libgccjit
# pacman -S mingw-w64-x86_64-libmangle-git

# pacman -S bash && \

pacman -S fish && \

# pacman -S which && \
# pacman -S filesystem && \
# pacman -Sy pacman pacman-mirrors msys2-runtime && \

pacman -S tar && \
pacman -S unrar && \
pacman -S unzip && \
pacman -S --needed base-devel mingw-w64-x86_64-toolchain && \
pacman -S ninja && \
pacman -S mingw-w64-x86_64-ninja && \
pacman -S patch && \
pacman -S patchutils && \
# pacman -S scons
# pacman -S swig

# pacman -S mingw-w64-x86_64-binutils
# pacman -S mingw-w64-x86_64-crt-git
# pacman -S msys2-devel && \
# pacman -S automake && \
# pacman -S autoconf && \
# pacman -S libtool && \
# pacman -S pkgconf && \
# pacman -S m4 && \
# pacman -S make && \
# pacman -S mingw-w64-x86_64-make
# pacman -S quilt

# pacman -S asciidoc
# pacman -S autoconf
# pacman -S autoconf-wrapper
# pacman -S autogen
# pacman -S automake
# pacman -S automake-wrapper
# pacman -S mingw-w64-x86_64-pkgconf
# pacman -S bison
# pacman -S btyacc
# pacman -S dos2unix
# pacman -S flex
# pacman -S gettext-devel
# pacman -S gdb
# pacman -S gperf
# pacman -S help2man
# pacman -S intltool
# pacman -S libunrar-devel
# pacman -S libtool
# pacman -S m4
pacman -S xmlto && \

pacman -S mingw-w64-x86_64-cmake && \

# pacman -S  mingw-w64-x86_64-qt5 && \
# pacman -S mingw-w64-x86_64-make && \
# pacman -Ss clang && \

pacman -S mingw-w64-x86_64-clang && \

# pacman -Ss lld && \

pacman -S mingw-w64-x86_64-lld && \
pacman -S mingw-w64-x86_64-lldb && \

pacman -S mingw-w64-x86_64-clang-tools-extra && \
pacman -S mingw-w64-x86_64-clang-analyzer && \
pacman -S mingw-w64-x86_64-compiler-rt && \
pacman -S cgdb && \
# Req. for building CCLS
pacman -S mingw-w64-x86_64-mlir && \
pacman -S mingw64/mingw-w64-x86_64-polly && \

# pacman -S gcc-libs && \
# pacman -S gdb && \
# pacman -S nano && \
# pacman -S nano-syntax-highlighting && \
# pacman -S mingw-w64-x86_64-gcc
# pacman -S mingw-w64-x86_64-gcc-libgfortran
# pacman -S mingw-w64-x86_64-gcc-libs
# pacman -S mingw-w64-x86_64-gcc-ada
# pacman -S mingw-w64-x86_64-gcc-fortran
# pacman -S mingw-w64-x86_64-gcc-objc
# pacman -S mingw-w64-x86_64-gdb
# pacman -S mingw-w64-x86_64-gdb-multiarch

pacman -S mingw-w64-x86_64-cppcheck && \
pacman -S mingw-w64-x86_64-astyle && \
pacman -S ssh-pageant-git && \
pacman -S git && \
pacman -S git-extras && \
pacman -S git-flow && \
pacman -S mingw-w64-x86_64-git-lfs && \

# pacman -S mingw-w64-x86_64-headers-git
# pacman -S mingw-w64-x86_64-tools-git
# pacman -S mingw-w64-x86_64-winpthreads-git
# pacman -S mingw-w64-x86_64-winstorecompat-git
# pacman -S mingw-w64-x86_64-libwinpthread-git

# pacman -S diffutils && \
# pacman -S diffstat && \
# pacman -S grep && \
# pacman -S mingw-w64-x86_64-ripgrep && \
# pacman -Ss msys2-launcher && \

# for ccls
pacman -S mingw-w64-x86_64-jq && \
pacman -S mingw-w64-x86_64-rapidjson && \
pacman -S mingw-w64-x86_64-ncurses && \

pacman -S mingw-w64-x86_64-meld3 && \
pacman -S ctags && \
pacman -S markdown && \
pacman -S python python-pip && \
pacman -S mingw-w64-x86_64-python-pynvim && \
pacman -S mingw-w64-x86_64-python-send2trash && \

pacman -S cdecl && \

# pacman -S msys/vim && \

# Libraries
# pacman -Ss glm (lib)
# pacman -Ss mingw-w64-x86_64-gtk3 (lib)
# pacman -Ss mingw-w64-x86_64-glade (lib)
# pacman -Ss gtkmm (lib)
# pacman -S mingw-w64-x86_64-freeglut
# pacman -S mingw-w64-x86_64-glew

# ARM MCU
# pacman -S mingw-w64-x86_64-arm-none-eabi-gcc
# pacman -S mingw-w64-x86_64-arm-none-eabi-gdb
# pacman -Ss openocd
# pacman -Ss stlink
# pacman -Ss arm

# RUST Compiler
# pacman -Ss rust
# pacman -S mingw-w64-x86_64-rust
# pacman -S mingw-w64-x86_64-cargo-c

# R-Click Context Menues
# https://github.com/njzhangyifei/msys2-mingw-shortcut-menus
git clone https://github.com/njzhangyifei/msys2-mingw-shortcut-menus && \
cd ~/msys2-mingw-shortcut-menus/ && \
./install && \
cd ~/ && \
rm -rf ~/msys2-mingw-shortcut-menus/ \

