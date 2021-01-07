#!/bin/bash

cd ~/  && \
rm -rf ~/Tulu-C-IDE && \
git clone https://github.com/Pinaki82/Tulu-C-IDE  && \
rm -rf ~/Tulu-C-IDE/.git  && \
rm ~/Tulu-C-IDE/README.md ~/Tulu-C-IDE/LICENSE ~/Tulu-C-IDE/tulu_c_ide_download.sh && \
# https://www.tecmint.com/sync-new-changed-modified-files-rsync-linux/
rsync --archive --recursive --verbose --progress ~/Tulu-C-IDE/.vim/autoload/* ~/.vim/autoload && \
rsync --archive --recursive --verbose --progress ~/Tulu-C-IDE/.vim/bitmaps/* ~/.vim/bitmaps && \
# rsync --archive --recursive --verbose --progress ~/Tulu-C-IDE/.vim/plugin/* ~/.vim/plugin && \
# https://unix.stackexchange.com/questions/501975/why-does-rsync-keep-skipping-the-directory-i-want-to-sync
rsync --archive --recursive --verbose --progress ~/Tulu-C-IDE/.vimdotcommon// ~/.vimdotcommon &&\
rsync --archive --recursive --update --verbose --progress ~/Tulu-C-IDE/.vimdotlinux// ~/.vimdotlinux &&\
rsync --archive --recursive --update --verbose --progress ~/Tulu-C-IDE/.vimdotwin// ~/.vimdotwin &&\
rsync --verbose --progress ~/Tulu-C-IDE/.vim/plugged/NOTE.txt ~/.vim/plugged/NOTE.txt && \
rsync --verbose --progress ~/Tulu-C-IDE/.gvimrc ~/Tulu-C-IDE/.vimrc ~/ && \
rm -rf ~/Tulu-C-IDE \
