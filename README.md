# Tulu-C-IDE

A simple Vim configuration to edit C/C++ codes.

My own Vim/GVim configuration to turn Vim into a minimalistic C/C++ code editor that resembles an IDE. This project is named after my pet Tulu, pronounced as Twoo'loo. Tulu means 'A Cotton Ball' in the Bengali Language.

Tulu is configured to have a minimalistic approach suitable for those who want to configure their own Vim Text Editor further after having all the core functions they will require to get a fully working C/C++ code editor.

If you are interested in a simple yet powerful Vim Text Editor configuration for your C/C++ codes, please clone the Git repository in your HOME directory, open Vim, and type in the command-mode ":PlugInstall" then run ":PlugUpgrade" because this configuration relies on vim-plug plugin manager.

Installation:

On Windows, you can download the latest version in a zip archive from the main branch or the release page (achieved releases can be a little older) and extract the contents to %userprofile% directory.

On Linux, you can either download the latest release in a .tar.gz archive and extract the contents to your home ~/ directory or run the following script:
```
sh tulu_c_ide_download.sh
```
File: tulu_c_ide_download.sh

Contents:
```
#!/bin/bash

cd ~/  && \
git clone https://github.com/Pinaki82/Tulu-C-IDE  && \
rm -rf ~/Tulu-C-IDE/.git  && \
rm ~/Tulu-C-IDE/README.md ~/Tulu-C-IDE/LICENSE ~/Tulu-C-IDE/tulu_c_ide_download.sh  && \
cd ~/Tulu-C-IDE && find ./ -maxdepth 1 -mindepth 1 -exec mv -f -t ~/ {} +  && \

# https://unix.stackexchange.com/questions/50487/how-to-move-all-files-and-folders-via-mv-command

rm -rf ~/Tulu-C-IDE \
```


![TULU_C_IDE](https://user-images.githubusercontent.com/16861933/99191990-4b7d1b80-2796-11eb-8ede-a4d9b181a950.jpg)

# Screenshots:

GVim-v8.2.1145.glibc2.15-x86_64.AppImage with this configuration running on Xubuntu 20.04.1 LTS Focal Fossa.
![GVim-AppImage](https://user-images.githubusercontent.com/16861933/99309879-249b1400-2880-11eb-967f-441bf0830f7a.png)

# Dependencies:

## Windows:

 [TDM-GCC](https://jmeubank.github.io/tdm-gcc/) (or any other MinGW-GCC compiler variant added to your system search path)

 [LLVM Clang](https://releases.llvm.org/download.html)
 
 [Ctags](https://github.com/universal-ctags/ctags-win32)
 
 [Cppcheck](http://cppcheck.sourceforge.net/): A static analysis tool for C/C++ code.
 
 [Splint](https://splint.org/): Annotation-Assisted Lightweight Static Checking.
 
 [Artistic Style](http://astyle.sourceforge.net/): A Free, Fast, and Small Automatic Formatter.

##### Recommended Programs:
 
 [git-scm](https://git-scm.com/)

 [Cmake](https://cmake.org/)
 
 [WinMerge](https://winmerge.org/?lang=en)

## Linux:
 
 [GCC](https://gcc.gnu.org/)
 
 [LLVM Clang](https://releases.llvm.org/download.html)
 
 [Ctags](http://ctags.sourceforge.net/)
 
 [Cppcheck](http://cppcheck.sourceforge.net/): A static analysis tool for C/C++ code.
 
 [Splint](https://splint.org/): Annotation-Assisted Lightweight Static Checking.
 
 [Artistic Style](http://astyle.sourceforge.net/): A Free, Fast, and Small Automatic Formatter.

##### Recommended Programs:

[Git](https://git-scm.com/download/linux)

[Cmake](https://cmake.org/)

[wget](https://www.gnu.org/software/wget/)

[Meld](https://meldmerge.org/)


If you are on an Ubuntu or an Ubuntu derivative Linux system, you can try the following or refer to this repository: [Xubuntu-minimum-shell-config](https://github.com/Pinaki82/Xubuntu-minimum-shell-config.git)

##### Required:

```
sudo apt update
sudo apt list --upgradable
sudo apt upgrade
sudo apt update

sudo apt install build-essential
sudo apt install llvm
sudo apt install clang
sudo apt install clang-tidy
sudo apt install clang-tools
sudo apt install libomp-dev
sudo apt install cdecl
sudo apt install cutils
sudo apt install vim-gtk
sudo apt install cppcheck
sudo apt install cppcheck-gui
sudo apt install splint
sudo apt install cmake-gui
sudo apt install cmake
sudo apt install wget
sudo apt install git
sudo apt install ddd
sudo apt install valgrind
sudo apt install astyle
sudo apt install ctags
sudo apt install autoconf
sudo apt install pkg-config
sudo apt install libx11-dev
sudo apt install libtool
sudo apt install autoproject
sudo apt install autogen
sudo apt install autotools-dev
sudo apt install automake
sudo apt install meld
```

##### Recommended:

```
sudo apt install gitg
sudo apt install libglib2.0-doc
sudo apt install fldiff
sudo apt install regexxer
sudo apt install vizigrep
sudo apt install searchmonkey
sudo apt install ninja-build
```

# Tulu-C-IDE relies on the following plugins:

[vim-plug](https://github.com/junegunn/vim-plug.git): A minimalist Vim plugin manager.

[The NERDTree](https://github.com/preservim/nerdtree.git): The NERDTree is a file system explorer for the Vim editor.

[vim-clang](https://github.com/justmao945/vim-clang.git): Use of clang to parse and complete C/C++ source files.

[Syntastic](https://github.com/vim-syntastic/syntastic.git): Syntastic is a syntax checking plugin for Vim created by Martin Grenfell. It runs files through external syntax checkers and displays any resulting errors to the user.

[matchparen++](https://github.com/vim-scripts/matchparenpp.git): Improvement over standard matchparen plugin.

[move](https://github.com/matze/vim-move.git): 
```
<A-k>   Move current line/selection up
<A-j>   Move current line/selection down
<A-h>   Move current character/selection left
<A-l>   Move current character/selection right
```

[NERD Commenter](https://github.com/preservim/nerdcommenter.git): Comment functions so powerful—no comment necessary. `:h NERD_commenter.txt`

[vimcaps](https://github.com/suxpert/vimcaps.git): Never be bothered by caps lock.

[AutoClose](https://github.com/vim-scripts/AutoClose.git): Inserts matching bracket, paren, brace or quote.

[auto tags gen](https://github.com/vim-scripts/auto-tags-gen.git): Plugin for creating tags automatically (C/C++).

[Vim plug-ins](https://github.com/WolfgangMehner/vim-plugins.git): This repository hosts the latest development versions of various Vim plug-ins. Currently maintained by Wolfgang Mehner.

[git-support](https://github.com/WolfgangMehner/git-support.git): Integration of Git for Vim/gVim.

[MiniBufExpl](https://github.com/weynhamz/vim-plugin-minibufexpl.git):  Elegant buffer explorer - takes very little screen space.

[SingleCompile](https://github.com/xuhdev/SingleCompile.git): A Vim plugin making it more convenient to compile and run a single source file.

[vim-wipeout](https://github.com/artnez/vim-wipeout.git): Destroy all buffers that are not open in any tabs or windows. `:Wipeout`

[code_complete](https://github.com/Pinaki82/code_complete.git): Function parameter complete, code snippets, and much more.

[artistic_styler_console_direct.vim](https://github.com/Pinaki82/artistic_styler_console_direct.vim.git): Artistic Style code formatter plugin for Vim/GVim.

[VimLongLineMarker](https://github.com/Pinaki82/VimLongLineMarker.git): Long Line Marker for Vim/GVim.

[Omni-Completion-at-CTRL-SPACE](https://github.com/Pinaki82/Omni-Completion-at-CTRL-SPACE.git): Vim/GVim Omni Completion at CTRL+SPACE. Can be customised.

[vim-move-Keyboard-Shortcut](https://github.com/Pinaki82/vim-move-Keyboard-Shortcut.git): Custom Keyboard Shortcut for [vim-move](https://github.com/matze/vim-move.git) plugin.

[Vim-Syntastic-Setup](https://github.com/Pinaki82/Vim-Syntastic-Setup.git): Custom Settings for [Syntastic](https://github.com/vim-syntastic/syntastic.git) Vim plugin.

[TimeStamp2](https://github.com/Pinaki82/TimeStamp2.git): Vim/GVim plugin to add/update the timestamp.

[vim-clang-Settings](https://github.com/Pinaki82/vim-clang-Settings.git): Custom Settings for the vim-clang Vim/GVim plugin.

[stlrefvim](https://github.com/vim-scripts/stlrefvim.git): A C++ Standard Template Library reference manual.

[crefvim2](https://github.com/Pinaki82/crefvim2.git): CRefVim2: a C-reference manual for Vim, originally created by Christian Habermann.

[YankRing.vim](https://github.com/vim-scripts/YankRing.vim.git): Maintains a history of previous yanks, changes and deletes.

[Reload-Button](https://github.com/Pinaki82/Reload-Button.git): A simple GVim plugin to reload the current buffer.

[Mustang Vim Colorscheme](https://github.com/croaker/mustang-vim.git): This is a modified version of the awesome mustang colorscheme by hcalves, published on deviantART.

[mustang_green-Vim-Colourscheme](https://github.com/Pinaki82/mustang_green-Vim-Colourscheme.git): A dark Vim colour scheme.

[oh-la-la](https://github.com/Pinaki82/oh-la-la.git): High contrast dark color scheme with black background.



