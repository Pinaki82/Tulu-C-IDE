# Tulu-C-IDE

A simple Vim configuration to edit C/C++ codes.

My own Vim/GVim configuration to turn Vim into a minimalistic C/C++ code editor that resembles an IDE. This project is named after my pet Tulu, pronounced as Twoo'loo. Tulu means 'A Cotton Ball' in the Bengali Language.

Tulu is configured to have a minimalistic approach suitable for those who want to configure their own Vim Text Editor further after having all the core functions they will require to get a fully working C/C++ code editor.

If you are interested in a simple yet powerful Vim Text Editor configuration for your C/C++ codes, please clone the Git repository in your HOME directory, open Vim, and type in the command-mode ":PlugInstall" then run ":PlugUpgrade" because this configuration relies on vim-plug plugin manager.

Installation:

On Windows, you can download the latest release in a zip archive and extract the contents to %userprofile% directory.

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
