#!/bin/bash

# ***** WARNING *****
# Do NOT BLINDLY run this script.
# READ EVERY LINE before running this script.
# Make necessary changes if needed.
# All other files except the files in the directories ~/.vim/plugged/ and
# ~/.vim/plugin/ will be overwritten by the latest GitHub repository contents.
# If you have modified the configuration, please keep a backup
# and merge your customisation from the backup using Meld or VimDiff
# once the update is done.

cd ~/  && \
rm -rf ~/Tulu-C-IDE && \
git clone https://github.com/Pinaki82/Tulu-C-IDE  && \
rm -rf ~/Tulu-C-IDE/.git  && \
rm ~/Tulu-C-IDE/README.md ~/Tulu-C-IDE/LICENSE ~/Tulu-C-IDE/tulu_c_ide_download.sh ~/GIT+SSH+GPG-and-Code-Signing.md && \
# https://www.tecmint.com/sync-new-changed-modified-files-rsync-linux/
rsync --archive --recursive --verbose --progress ~/Tulu-C-IDE/.vim/autoload/* ~/.vim/autoload && \
rsync --archive --recursive --verbose --progress ~/Tulu-C-IDE/.vim/bitmaps/* ~/.vim/bitmaps && \
rsync --archive --recursive --verbose --progress ~/Tulu-C-IDE/.vim/updater// ~/.vim/updater &&\
# https://unix.stackexchange.com/questions/501975/why-does-rsync-keep-skipping-the-directory-i-want-to-sync
rsync --archive --recursive --verbose --progress ~/Tulu-C-IDE/.vimdotcommon// ~/.vimdotcommon &&\
rsync --archive --recursive --update --verbose --progress ~/Tulu-C-IDE/.vimdotlinux// ~/.vimdotlinux &&\
rsync --archive --recursive --update --verbose --progress ~/Tulu-C-IDE/.vimdotwin// ~/.vimdotwin &&\
rsync --verbose --progress ~/Tulu-C-IDE/.vim/plugged/NOTE.txt ~/.vim/plugged/NOTE.txt && \
rsync --verbose --progress ~/Tulu-C-IDE/.gvimrc ~/Tulu-C-IDE/.vimrc ~/ && \
rm -rf ~/Tulu-C-IDE \
