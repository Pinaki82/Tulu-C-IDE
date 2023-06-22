#!/bin/bash

pacman -Syu && \
pacman -Syu && \
pacman -Su && \

# pacman -S bash && \

pacman -S fish && \

# pacman -S which && \
# pacman -S filesystem && \
#pacman -Sy pacman pacman-mirrors msys2-runtime && \

pacman -S tar && \
pacman -S --needed base-devel mingw-w64-x86_64-toolchain && \

# pacman -S msys2-devel && \
# pacman -S automake && \
# pacman -S autoconf && \
# pacman -S libtool && \
# pacman -S pkgconf && \
# pacman -S m4 && \
# pacman -S make && \

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

# pacman -S gcc-libs && \
# pacman -S gdb && \
# pacman -S nano && \
# pacman -S nano-syntax-highlighting && \

pacman -S mingw-w64-x86_64-cppcheck && \
pacman -S mingw-w64-x86_64-astyle && \
pacman -S ssh-pageant-git && \
pacman -S git && \
pacman -S git-extras && \
pacman -S git-flow && \
pacman -S mingw-w64-x86_64-git-lfs && \

# pacman -S diffutils && \
# pacman -S diffstat && \
# pacman -S grep && \
# pacman -Ss msys2-launcher && \

pacman -S mingw-w64-x86_64-meld3 && \
pacman -S ctags && \
pacman -S markdown && \
pacman -S python python-pip && \

pacman -S cdecl && \

# pacman -S msys/vim && \

# pacman -Ss glm (lib)
# pacman -Ss mingw-w64-x86_64-gtk3 (lib)
# pacman -Ss mingw-w64-x86_64-glade (lib)
# pacman -Ss gtkmm (lib)

# ARM MCU
# pacman -Ss openocd
# pacman -Ss stlink
# pacman -Ss arm

# RUST Compiler
# pacman -Ss rust

# R-Click Context Menues
# https://github.com/njzhangyifei/msys2-mingw-shortcut-menus
git clone https://github.com/njzhangyifei/msys2-mingw-shortcut-menus && \
cd ~/msys2-mingw-shortcut-menus/ && \
./install && \
cd ~/ && \
rm -rf ~/msys2-mingw-shortcut-menus/ \

