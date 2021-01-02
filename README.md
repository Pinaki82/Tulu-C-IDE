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

GVim Version 8.1.2269 (from Ubuntu repository) with this configuration running on Xubuntu 20.04.1 LTS Focal Fossa.
![Screenshot at 19-53-28](https://user-images.githubusercontent.com/16861933/103137019-5dce6b80-46eb-11eb-8fab-bf52636b4493.png)

GVim Version 8.2.12 from [PortableApps.com](https://portableapps.com/) running on Windows 10 (x64) Pro 20H2 with this configuration. Yes, this configuration runs even on portable versions of GVim!
![2020-12-25 20_01_31- No Name  - GVIM](https://user-images.githubusercontent.com/16861933/103137187-ba7e5600-46ec-11eb-8ebc-77b5e9dfcf2d.png)

# Dependencies:

## Windows:

 [TDM-GCC](https://jmeubank.github.io/tdm-gcc/) (or any other MinGW-GCC compiler variant added to your system search path)

 [LLVM Clang](https://releases.llvm.org/download.html)
 
 [Ctags](https://github.com/universal-ctags/ctags-win32)
 
 [Cppcheck](http://cppcheck.sourceforge.net/): A static analysis tool for C/C++ code.
 
 [Splint](https://splint.org/): Annotation-Assisted Lightweight Static Checking.
 
 [Artistic Style](http://astyle.sourceforge.net/): A Free, Fast, and Small Automatic Formatter.
 
 [Java Runtime Environment](https://www.java.com/en/download/manual.jsp)

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
 
 Java Runtime Environment.

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
sudo apt install -f

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
sudo apt install default-jre
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

[The NERDTree](https://github.com/preservim/nerdtree.git): The NERDTree is a file system explorer for the Vim editor. `:h nerdtree`

[vim-clang](https://github.com/justmao945/vim-clang.git): Use of clang to parse and complete C/C++ source files. `:h clang.txt`

[Syntastic](https://github.com/vim-syntastic/syntastic.git): Syntastic is a syntax checking plugin for Vim created by Martin Grenfell. It runs files through external syntax checkers and displays any resulting errors to the user. `:h syntastic` `:h syntastic-checkers.txt`

[matchparen++](https://github.com/vim-scripts/matchparenpp.git): Improvement over standard matchparen plugin.

[move](https://github.com/matze/vim-move.git): `:h move.txt`
```
<A-k>   Move current line/selection up
<A-j>   Move current line/selection down
<A-h>   Move current character/selection left
<A-l>   Move current character/selection right
```

[NERD Commenter](https://github.com/preservim/nerdcommenter.git): Comment functions so powerful—no comment necessary. `:h NERD_commenter.txt`

[vimcaps](https://github.com/suxpert/vimcaps.git): Never be bothered by caps lock.

[AutoClose](https://github.com/vim-scripts/AutoClose.git): Inserts matching bracket, paren, brace or quote.

[auto tags gen](https://github.com/Pinaki82/auto-tags-gen.git): Plugin for creating tags automatically (C/C++). `:h auto_tags_gen.txt`

[Vim plug-ins](https://github.com/WolfgangMehner/vim-plugins.git): This repository hosts the latest development versions of various Vim plug-ins. Currently maintained by Wolfgang Mehner. `:h csupport` `:h vimsupport` `awksupport` `:h bashdbintegration` `:h bashsupport` `:h latexsupport` `:h luaref51` `:h luaref52` `:h luaref53` `:h luasupport` `:h perlsupport` `:h templatesupport` `:h toolbox` `:h toolboxcmake` `:h toolboxdoxygen` `:h toolboxmake`

[git-support](https://github.com/WolfgangMehner/git-support.git): Integration of Git for Vim/gVim. `:h gitsupport`

[MiniBufExpl](https://github.com/weynhamz/vim-plugin-minibufexpl.git):  Elegant buffer explorer - takes very little screen space. `:h minibufexpl`

[SingleCompile](https://github.com/xuhdev/SingleCompile.git): A Vim plugin making it more convenient to compile and run a single source file. `:h singlecompile`

[vim-wipeout](https://github.com/artnez/vim-wipeout.git): Destroy all buffers that are not open in any tabs or windows. `:Wipeout` Help file not available.

[code_complete](https://github.com/Pinaki82/code_complete.git): Function parameter complete, code snippets, and much more.

[artistic_styler_console_direct.vim](https://github.com/Pinaki82/artistic_styler_console_direct.vim.git): Artistic Style code formatter plugin for Vim/GVim.

[VimLongLineMarker](https://github.com/Pinaki82/VimLongLineMarker.git): Long Line Marker for Vim/GVim.

[Omni-Completion-at-CTRL-SPACE](https://github.com/Pinaki82/Omni-Completion-at-CTRL-SPACE.git): Vim/GVim Omni Completion at CTRL+SPACE. Can be customised.

[vim-move-Keyboard-Shortcut](https://github.com/Pinaki82/vim-move-Keyboard-Shortcut.git): Custom Keyboard Shortcut for [vim-move](https://github.com/matze/vim-move.git) plugin.

[Vim-Syntastic-Setup](https://github.com/Pinaki82/Vim-Syntastic-Setup.git): Custom Settings for [Syntastic](https://github.com/vim-syntastic/syntastic.git) Vim plugin.

[TimeStamp2](https://github.com/Pinaki82/TimeStamp2.git): Vim/GVim plugin to add/update the timestamp.

[vim-clang-Settings](https://github.com/Pinaki82/vim-clang-Settings.git): Custom Settings for the vim-clang Vim/GVim plugin.

[stlrefvim](https://github.com/vim-scripts/stlrefvim.git): A C++ Standard Template Library reference manual. `:h stlrefvim.txt`

[crefvim2](https://github.com/Pinaki82/crefvim2.git): CRefVim2: a C-reference manual for Vim, originally created by Christian Habermann. `:h crefvim.txt` `:h crefvimdoc.txt` 

[YankRing.vim](https://github.com/vim-scripts/YankRing.vim.git): Maintains a history of previous yanks, changes and deletes. `:h yankring.txt`

[Reload-Button](https://github.com/Pinaki82/Reload-Button.git): A simple GVim plugin to reload the current buffer.

[convert-line-endings](https://github.com/Pinaki82/convert-line-endings.git): Convert Line Endings to Unix/Windows, `\lnu` and `\lnd`.

[AutoComplPop](https://github.com/vim-scripts/AutoComplPop.git): With this plugin, your vim comes to automatically opens popup menu for
completions when you enter characters or move the cursor in Insert mode.

[vim-grammarous
](https://github.com/rhysd/vim-grammarous.git): A frontend grammar checker for Vim that uses [LanguageTool](https://languagetool.org/download/) in the backend. Simply do `:GrammarousCheck`. This plugin automatically downloads [LanguageTool](https://languagetool.org/download/) on Linux, which requires Java 8+. Install Java Runtime Environment on Ubuntu derivatives: `sudo apt install default-jre`. On Windows OS, extract "languagetool-*.zip" in the 'misc' (`%userprofile%\.vim\plugged\vim-grammarous\misc` or `%userprofile%\.vim\misc`) folder.

[vim-bettersearch](https://github.com/kenng/vim-bettersearch.git): Notepad++ like search in Vim. `:BetterSearch<TAB>`.

[MRU](https://github.com/yegappan/mru.git): The Most Recently Used (MRU) plugin provides an easy access to a list of 
recently opened/edited files in Vim. This plugin automatically stores the 
file names as you open/edit them in Vim.

[TaskList.vim](https://github.com/vim-scripts/TaskList.vim.git): This script is based on the eclipse Task List. It will search the file for FIXME, TODO, and XXX (or a custom list) and put them in a handy list for you to browse which at the same time will update the location in the document so you can see exactly where the tag is located. **Usage:** Press `<Leader>t` then `Esc`. Or, `:TaskList`. Press `q` to close the Task List window. Read the plugin file [here](https://github.com/vim-scripts/TaskList.vim/blob/master/plugin/tasklist.vim) to find the instructions.

[Tagbar](https://github.com/preservim/tagbar.git): A class outline viewer for Vim. See Functions, prototypes, Classes, Macros, Structures etc. in a separate vertical window and click on an item to find them in the actual file. **Usage:** `:TagbarToggle`.

[repeaterchar.vim](https://github.com/Pinaki82/repeaterchar.vim.git): Define a character and repeat it n-times. How would you write ~~~~~~~ 100-times? **Usage:** `<C-u>` then fill out the options.

[Clear-Search-Highlight-in-Vim](https://github.com/Pinaki82/Clear-Search-Highlight-in-Vim.git): Cleans up Search Highlight.

[tracktime.vim](https://github.com/Pinaki82/tracktime.vim.git): Vim uptime.

[Mustang Vim Colorscheme](https://github.com/croaker/mustang-vim.git): This is a modified version of the awesome mustang colorscheme by hcalves, published on deviantART.

[mustang_green-Vim-Colourscheme](https://github.com/Pinaki82/mustang_green-Vim-Colourscheme.git): A dark Vim colour scheme.

[oh-la-la](https://github.com/Pinaki82/oh-la-la.git): High contrast dark color scheme with black background.

## Change the default GVim theme:

In your HOME directory, there is a file `.givmrc`. Open it and uncomment some lines if you want a dark theme. Instructions provided. In Vim, `"` is used at the beginning of a line to comment it.

## Things to do after installation:

Find the script in `%userprofile%\.vim\plugin\temporary.vim` or, `~/.vim/plugin/temporary.vim` and comment out a few lines as follows:

Change these lines

`silent execute '!mkdir "'.$HOME.'/.vimbackup"'`

`silent execute '!mkdir "'.$HOME.'/.vimswap"'`

`silent execute '!mkdir "'.$HOME.'/.vimviews"'`

`silent execute '!mkdir "'.$HOME.'/.vimundo"'`


To

`"silent execute '!mkdir "'.$HOME.'/.vimbackup"'`

`"silent execute '!mkdir "'.$HOME.'/.vimswap"'`

`"silent execute '!mkdir "'.$HOME.'/.vimviews"'`

`"silent execute '!mkdir "'.$HOME.'/.vimundo"'`


These directories are required by this configuration to work properly. Otherwise, Vim would create backup files, Vim-view settings, and other temporary files in the directories where the codes will be edited. Once you have installed the plugins by issuing the commands `:PlugInstall` and `:PlugUpgrade`, make a few changes to this configuration to suit your needs. Those directories are not needed once created, and you may like a dark theme. Change the theme if you prefer a dark theme over the default white colour. `<Ctrl+Alt+F11>` and `<Ctrl+Shift+F11>` can always be used regardless of the set theme to load at startup.

`"` in Vim scripts comments out a line, like `//comment` and `/*comment*/` in C/C++. Multiline comments are unavailable in Vim scripts.

On Linux, the plugin [auto-tags-gen](https://github.com/Pinaki82/auto-tags-gen.git) needs to be build from source. It's easy. Open the directory `~/.vim/plugged/auto-tags-gen` with you file manager. Open terminal in this location. On Xubuntu, `<F4>` will launch the terminal in the selected directory. Type `make`, then move the file `libauto_tag_gen.so` to `~/.vim/plugged/auto-tags-gen/plugin` folder.

## To the First Time Users:

### Normal Mode

Press `<Esc>` to put Vim into Normal mode. Vim usually starts in this mode.

![Esc](https://user-images.githubusercontent.com/16861933/102935301-e2db3a00-44cb-11eb-9185-840a070c6e33.png)


### Command Mode

Press _Colon_ i.e., `<Shift+;>` to put Vim into Command mode. Instead of Pressing `<Shift+;>` type **__;__** and it will have the same effect in this setup.

![Shift+colon_ani](https://user-images.githubusercontent.com/16861933/102935218-baebd680-44cb-11eb-996c-f92435a903c1.gif)

![NormalModetoCommandMode](https://user-images.githubusercontent.com/16861933/102935234-bfb08a80-44cb-11eb-8b65-fa8eba9df5d8.gif)

NOTE: We can take advantage of autocompletion with the `<TAB>` key in Command mode. After typing a few characters press `<TAB>` and navigate using the Right/Left Arrow key or even by hitting the `<TAB>` key over and over.

![TabAutocompletionCommandMode](https://user-images.githubusercontent.com/16861933/103034147-3f049380-458a-11eb-9a44-71c192ae2e58.gif)

### Quit Vim

* Discard all changes and quit without saving anything.

`:q!`

* Save changes to the currently opened buffer (the file being edited. It's called buffer in Vim) then quit Vim.

`:x`

* Save the currently opened buffer.

`:w`


### Insert Mode

Vim allows typing into the editor window in a usual manner in this mode. Other modes can allow typing, e.g., Visual mode, but for purposes like selecting texts.
To go to Insert mode from Normal mode, press `<i>` or `<Insert>`.
##### Insert command with specific purposes:

* `<i>` : Position cursor onto the current character and switch to Insert mode.
* `<I>` : Jump to the beginning of the line and switch to Insert mode.
* `<a>` : Append. Move the cursor position just after the position of the current character and go to Insert mode.
* `<A>` : Append to the EOL. Jump to the end of the line.
* `<o>` : Insert a new line beneath the line on which the cursor is located and switch to Insert mode.
* `<O>` : Insert a new line above the line on which the cursor is located and switch to Insert mode.

### Visual Mode

Press `<v>` to switch to this mode. For example, position the cursor on any text then press `<v>` then select the texts next to the character by holding the `<l>` key. Press `<x>` to cut the selection. Cut operation keeps the text in Vim's memory which is known as **_registers_**.

The section operation can be done in any direction; leftwards, rightwards, upwards, and downwards. Just press `<h>` to move the cursor/selection to the left, `<l>` to move the cursor/selection to the right. In between them, `<k>` to move the cursor/selection upwards, and `<j>` to move the cursor/selection downwards.

### Replace Mode
Put the cursor on any character and Press Capital `<R>` to switch to this mode. Type over the text to replace with what you want. Small case `<r>` will also take you to the replace mode but it will replace only a single character.

![ReplaceMode](https://user-images.githubusercontent.com/16861933/103017257-58e1ae80-4569-11eb-9dcd-b5aad5883fe4.gif)

### Navigation
Vim allows navigating through the text in Normal mode. Left, Down, Up, Left buttons are mapped to `<H>` `<J>` `<K>` `<L>` keys respectively. Mnemonics: Remember that `<H>` is at the Left side and `<L>` is at the Right. Think of `<J>` as an Umbrella ☂️ that you use as a parachute 🪂 while jumping off an aeroplane. For `<K>`, remember that the __s"K"y__ (sky) is above. 😊

Arrow keys can be used in Insert mode.

`<O>` will position the cursor to the beginning of the line and `<$>` to the end.

![Navigation](https://user-images.githubusercontent.com/16861933/103015391-5b8ed480-4566-11eb-934e-feb573130c0e.png)

### Switch between Modes
Press `<Esc>` key to switch to Normal mode first. Now you are ready to switch to any mode you want.

![Esc](https://user-images.githubusercontent.com/16861933/102935301-e2db3a00-44cb-11eb-9185-840a070c6e33.png)

### Common Quirks:

You can press `dd` in Normal mode to delete the entire line, `yy` to copy the line and `p` to paste the line copied to the register into the next line, `<Shift+p>` to paste it above the selected line. `<Shift+j>` joins two lines (the selected line + the next line). Use `x` in Normal mode to delete characters. Think of it as the Delete button. The Delete button can also be used. The deleted character will remain in the clipboard.

## Splitting Windows (Text Areas):

![C-W then s](https://user-images.githubusercontent.com/16861933/103246021-01d44300-4988-11eb-90e4-cc7fe0ffa7b8.gif)

In Normal mode:

Split Horizontally: `<Ctrl+w>` then `s`.

Split Vertically: `<Ctrl+w>` then `v`.

![SplittingWindows](https://user-images.githubusercontent.com/16861933/103242683-31ca1900-497d-11eb-90de-60fc2506efbb.gif)

## Navigate Through the Active Buffers:

In Normal mode:

`<Ctrl+o>` and `<Ctrl+i>`.

NOTE: `<Ctrl+o+o>` will open the last edited file.

![NavigateThroughTheActiveBuffers](https://user-images.githubusercontent.com/16861933/103243149-e87ac900-497e-11eb-8118-e0144a62e06f.gif)

## Navigate Through the Active Windows (Text Areas):

In Normal mode:

`<Ctrl+w><Ctrl+w><Ctrl+w>...`

And/Or,

`<Ctrl+w>` then `<h>`, `<j>`, `<k>`, `<l>`.

Look at the placement of the cursor inside the windows.

![NavigateThroughTheActiveWindows](https://user-images.githubusercontent.com/16861933/103243558-42c85980-4980-11eb-8ad1-6313fa7a9c1c.gif)

## Close windows:

In Normal mode:

`<Ctrl+w>` then `<c>`.

![CloseWindowCtrlW-C](https://user-images.githubusercontent.com/16861933/103244242-6391ae80-4982-11eb-890f-e47e094583af.gif)

Also, in Command mode:

`:close`

![CloseWindowColonClose](https://user-images.githubusercontent.com/16861933/103244606-912b2780-4983-11eb-9117-2dbf990dafca.gif)

Close all active windows except the selected one:

`:Wipeout`

`:bwipeout`

Close the only active window:

`:confirm bd`

`bd` stands for 'buffer delete'.

![Wipeout-n-confirmbd](https://user-images.githubusercontent.com/16861933/103244645-a99b4200-4983-11eb-8c94-8645ed97a59e.gif)

## Find the matching brackets:

Place the cursor on a bracket, then press `<Shift+5>` i.e.,

`%`

![FindTheMatchingBrackets](https://user-images.githubusercontent.com/16861933/103245018-cdab5300-4984-11eb-97b2-e27f5dac94bf.gif)

## The FIRST Line and the LAST Line:

Go to the FIRST Line: `gg`

Go to the LAST Line: `<Shift+g>`

![FistLineLastLine](https://user-images.githubusercontent.com/16861933/103245307-bd47a800-4985-11eb-91f7-f236257b7d2b.gif)

## Go to the Beginning of the Line and the End of the Line:

Type

`ZERO [0]` to go to the BEGINNING of the line.

`$` to go to the END of the line.

![ZeroDollarBOL-EOL](https://user-images.githubusercontent.com/16861933/103245541-82923f80-4986-11eb-8317-f60a45f71e3f.gif)

# Custom Keymaps and Keyboard Shortcuts
### The following commands can come handy if inserted to the Vim Commandline in Command Mode:

`:help index`

`:scriptnames`

`:map!`

`:map`

Try it yourself and see!

`CTRL-X` is cut

`CTRL-C` is copy

`CTRL-V` is paste

`CTRL-S` is save

`CTRL-A` is Select all

`CTRL-Z` is undo

`CTRL-Y` is redo

`CTRL-D` is Buffer Delete (closes the currently opened file and also deletes it from Vim's memory)

-----------------------------------

`Ctrl+F4`

Mode: Normal, Insert both.

Closes the current file, but keeps it in the buffer (memory).

-----------------------------------

`F5`

Mode: Insert Mode only.

Makes texts uppercase.

aaaaa -> AAAAA

-----------------------------------

`Shift+F5`

Mode: Insert Mode only.

Makes texts lowercase.

AAAAA -> aaaaa

-----------------------------------

Mode: Insert Mode only.

Makes text uppercase `F5`, and lowercase `SHIFT-F5` respectively.

-----------------------------------

Some code folding `<F8>` or `<Shift+F8>` or `<Space>`

`<F8>=za in Normal mode`

`<Shift+F8>=zR in Normal mode`

`<Space>=zf in Normal mode`

-----------------------------------

`Shift+F8`

Mode: Normal, Insert both.

Unfolds everything.

-----------------------------------

`F8`

Mode: Normal, Insert both.

Fold/Unfold.

-----------------------------------

`F5`

Mode: Normal Mode only.

Reloads file.

`F5` or `\rd`

-----------------------------------
-----------------------------------

Note: Avoid Alt key while you can, for the sake of portability.
For example: In Linux, `Alt+F8` is used to resize the window of any kind. So it cannot be used.
Linux generally uses the Alt key to do different things.

-----------------------------------
-----------------------------------

`Ctrl+]` (In Normal Mode)

Mode: Normal Mode only.

Means: Jump to this tag.

Finds the pieces of stuff from the Tags related to header files etc., and opens the header. Uses index provided by the 'tags' for searching the header.

For example, put the cursor above a function name and press `Ctrl+]`, it will open the header containing the original definition.
You can Ctrl+Left-click (in normal Mode) to do the same.

-----------------------------------

`Ctrl+t` (In Normal Mode)

Mode: Normal Mode only.

Jumps back to the previous tag.

You can Ctrl+Right-click (in normal Mode) to do the same.

-----------------------------------

`Ctrl+f` (In Normal Mode)

Mode: Normal Mode only.

Find.

-----------------------------------

`Ctrl+h` (In Normal Mode)

Mode: Normal Mode only.

Find and replace.

-----------------------------------

`\hl` (In Normal Mode)

Turns Highlight Line and column ON-OFF

-----------------------------------

`<Alt-Shift-F11>` (In Normal Mode)

Reloads Default Theme.

-----------------------------------

`<Ctrl-Shift-F11>` (In Normal Mode)

Changes theme to MustangGreen

-----------------------------------

`Ctrl+n`

Mode: insert Mode only.

Omni completion forward.

Note: Omni completion is set to Clang-Complete here.

-----------------------------------

`Ctrl+p`

Mode: insert Mode only.

Omni completion backwards.

Note: Omni completion is set to Clang-Complete here.

-----------------------------------

`Ctrl+SpaceBar` and navigate through up-down arrow keys:

An easy alternative to `Ctrl+n` and `Ctrl+p`.

Mode: Insert Mode only.

-----------------------------------

YankRing plugin Configuration

```
:nnoremap <silent> <C-F11> :YRShow<CR>
<C-U>YRYankCount
```

-----------------------------------

Mode: Normal Mode only.

Long Line Marker (or Right Border or Right Margin) ON-OFF `\8`

-----------------------------------

## The reason for the existence of different modes in Vim:

A key combination can do a particular job in one mode, but the same combination can be used in another mode to accomplish a different task, thus augmenting the potential of the keyboard.



## Some useful commands (for Command mode):

-----------------------------------

`:echo $PATH`

Reflects the folders added to the path.

-----------------------------------

`:echo $VIMRUNTIME`

Shows the Vim installation folder.

-----------------------------------

`:echo $HOME`

Gives the home folder e.g., `C:\Users\"your_account_name"` as you do by typing `%userprofile%` (or `~/`) at the address bar.

Also,

`:echo $HOMEPATH`

Almost does the same thing.

-----------------------------------

`:echo $HOMEDRIVE`

Echoes the location of the system installation drive. Generally, `C:\` on Windows.

-----------------------------------

`:echo $MYVIMRC`

Displays the `.vimrc` file, in effect with the full path to the file.

Generally, `C:\Program Files\vim\_vimrc` or `C:\Program Files (x86)\vim\_vimrc`

or `/home/"your-user_account_name"/.vimrc` in Linux (`~/.vimrc`).

This file is extremely crucial because Vim loads configurations at program startup from this file.

To customize Vim, you can write you instructions to this file, as you can write the plugin files.

-----------------------------------

`:helptags $VIMRUNTIME/doc`

`:helptags $HOME/.vim/doc`

Creates a 'tags' file for search and navigation of help files in the plugin installation directories. Vim-Plug automatically does this for you, so you don't have to do this. However, you need to generate a 'tags' file in the runtime directory where Vim has been installed.

-----------------------------------

`:pwd`

Echoes the present working directory of the file being edited. After startup, this is your HOME directory.

-----------------------------------

`:set runtimepath?`

Displays a list of directories from where Vim can load plug-ins.

Echoes the folders that are being used by Vim.

-----------------------------------

`:set directory?`

Reflects the internally set directory for the temp and swap files.

Echoes the set directory (for storing temp files etc.).

-----------------------------------

`:scriptnames`

Displays the list of text-based scripts/plugins ( `_vimrc`, `.vim`, `*.vim` etc..) in use.

Note: Vim plugins are essentially text files, though there exist a few shared library based plugins.

-----------------------------------

`:browse confirm e`

Opens the GUI file browser.

`:browse confirm e D:\Code_Blocks\`

Opens the GUI file browser to locate the file you need in that directory.

-----------------------------------

`:bwipeout`

This command closes all the files, wiping out the hidden memory too.

When you close a file, Vim keeps it in its memory, making file hidden in the editor.

-----------------------------------

`:confirm bd`

It means, 'Confirm Buffer Delete'. Unloads only the currently opened file.

This command deletes nothing. It closes the file in the editor, wipes the hidden memory for that particular file.

-----------------------------------

`:e!`

Command to reload a file from hard disc. Unsaved changes are discarded.

Reloads the current buffer. Reloads only the currently opened file from disc.

-----------------------------------

`:w`

Vim, by default, does not save/alter a file if it is not changed/modified. This command forces Vim to re-write the file to disc.

Save (writes to disc) the file, even if the file has not been modified at all.

-----------------------------------

`:51`

`:78`

`:69`

Jumps to the line number provided.

-----------------------------------

`:q`

`:qa`

Exits/Quits Vim.

-----------------------------------

`:h crefvimdoc`

C Reference is a reference book plugin for the C language. This command opens its doc.

Specific to the docs of the cref plugin.

`:h cref`

Opens the C Language Reference.
Specific to cref plugin.

-----------------------------------

`:h 'statusline'`

An example to search the manual of Vim with specific options. This option searches for the 'statusline' related topics.

Opens Vim documentation with the topic 'statusline'.

-----------------------------------

## Leader `\`

![Bslash](https://user-images.githubusercontent.com/16861933/103035666-cdc6df80-458d-11eb-801b-219c79aa8e83.png)
 
### What is "Leader Key"?

In Vim, a leader key is generally (set by default) the "back-slash" key in Normal mode (not Command mode or any other mode), unless you define a different key as the leader.


In normal mode, press `\` then type `8` (not from the num-pad). See what happens! It will turn on/off the long line marker.

Various tasks can be performed in this manner. Many plugins map their functions through 'Leader' key.


In Normal mode, press the Leader (i.e. `\` key, it's the 'backslash' key) then,

`8` -> Turns off long line marker.

`hl` -> Toggles Line-Column Highlight.

### Leader Timeout Quirk:

Typing a leader based shortcut or any other shortcut requires some typing effort thus takes some time.
So I set the timeout length to 4.5 seconds. you can easily see it here:- `%userprofile%\.vimdotcommon\.vimrc2.vim`
Or,

`~/.vimdotcommon/.vimrc2.vim`

as:

`:set timeout timeoutlen=4500`

This means you get 4.5 sec to complete typing your instruction. The default was `:set timeout timeoutlen=-1` or, `:set timeout timeoutlen=100`

In this approach, we take a few obvious advantages of that extended duration, but the only problem is when you have a very short shortcut such as `\t`
you will have to wait for 4.5 sec to see the effect. But it is a trivial issue compared to the disadvantages of a short duration within which we would have to complete typing out some long instructions.

Here some plugins e.g., c-vim uses leader based shortcuts in Insert mode also.

Thus typing `\n` looks like `n` for 4.5 sec. `printf("Hello World\n` would look like `printf("Hello Worldn` for 4.5 sec.

If it happens so, try to press some other key that would not affect your shortcut.

Specifically, you may try one of the 'arrow' keys (preferably the 'right-arrow', since you are moving to the right) or the 'Esc' key.

If it still annoys you, try to lower the timeout-length as you prefer like,

`:set timeout timeoutlen='an amount of your choice'`, that's all.

-----------------------------------
-----------------------------------

#### YankRing plugin (The multi-clipboard plugin):

**Note:** This plugin changes the default behaviour of "Normal mode -> Shift+Y copy (entire line)" in vim, so please use Normal mode then type `yy` to copy the entire line.

1) What does it do?

If you need tons of multiple texts/lines to copy to computers' clipboard, it's impossible. Computers can remember only one thing you copied. Neither a machine will remember multiple things you need as clipboard memories, nor it will remember the set of character strings you delete. Shutdown the computer, it will forget the clipboard contents.

Vim offers a method called registers to store the clipboard in a text file `%userprofile%\_viminfo` (`~/.viminfo`) so that you can access the clipboard even after you restart the machine. Vim relies on registers rather than system clipboard, though it can access the system clipboard.

The obvious advantages of registers are:

1. Many clipboard contents can be stored and accessed.

2. The line you delete can also be stored as one clipboard content.

3. Stored clipboard can be used even after a system restart or any time, which, of course, cannot be done by using the conventional system clipboard once the clipboard gets cleared.

On the other hands, using Vim registers is tricky.

This plugin stands as an intermediator to overcome the challenges of storing multiple clipboards.

It stores its clipboard from vim registers to `%userprofile%\yankring_history_v2.txt` or (`~/yankring_history_v2.txt`).

Shutdown the computer. The next time when you will open Vim, your clipboard history will be accessible again.

======================

2) **Usage:**

Hit escape and put GVim into normal mode. Type `v` from the keyboard, Vim will go into 'Visual Mode'. Select the portion you need and press `y`. It's copied to 'vim register' and yankring's scratch-file.

Now its time to paste the clipboard content.

`<Ctrl+v>` may not work, go to Normal mode (Esc), type `p` from the keyboard.

On the same line, Press `<Ctrl+p>` or `<Ctrl+n>` to choose the desired content.

Always copy a portion in Visual mode.

`p` means paste after the cursor and `P` means before the cursor.

The line you delete typing `dd` in Normal mode or the line you copy in Normal mode by typing `yy` or `<Shift+Y>`, called yank operation, which is stored in vim registers.

These are the default Vim functionalities. YankRing uses native Vim features in the background and brings some ease to the user.

Deleting a line or yanking a line are Vim's native functionalities, and are not something that YankRing brings in; but, the combination of these functions and YankRing in a single place is useful, and it is quite similar to Notepad++'s multi-clipboard plugin.


`5p` means paste the content 5-times after the cursor.

`:YRShow` opens the Yankring Clipboard Monitor window.

Selecting a line in that window and pressing `d` will eliminate the contents in that line.

Selecting a line from the YankRing window and Typing 1-9 (not from the Numpad) will write the content of that line into the main text.

`:YRSearch` searches the part of the content you are looking for.


I mapped,
Normal mode `<C-F11>` for `:YRShow`


To know more, type `:h yankring` in Command mode.

#### 'vim-move' plugin -> Shift lines and selections with vim-move.

By default, `<Alt+k>` and `<Alt+j>` move the current line **Up** and **Down** in normal mode.

You can prefix the calls with a count, e.g., `5 <Alt + j>` which will then shift the line or selection relative to that number. For example, select line number 30 in Normal mode then type `5 <Alt+k>`, the line will be moved in the upward direction to line number 25.

For help, in Command mode, do

`:h move`

**Usage:**

```
<A-k>   Move current line/selection up
<A-j>   Move current line/selection down
<A-h>   Move current character/selection left
<A-l>   Move current character/selection right
```

See it in action:

![vim-move](https://user-images.githubusercontent.com/16861933/103403659-f8f59400-4b76-11eb-850d-b63c6b6ccc85.gif)

#### [AutoComplPop](https://github.com/vim-scripts/AutoComplPop.git) -> Pops up auto-completion menu from set dictionaries and opened buffers.

It can also complete filename with path.

Menu -> Plugin -> ACP-auto-popup for turning on/off this feature.

![2020-12-31 15_03_49-sfn_converter_2 c + (P__SFN_cnvrtr_src) - GVIM](https://user-images.githubusercontent.com/16861933/103404672-8090d200-4b7a-11eb-9f72-7d0eba94c86b.png)

![2020-12-31 15_05_35-sfn_converter_2 c + (P__SFN_cnvrtr_src) - GVIM](https://user-images.githubusercontent.com/16861933/103404675-8686b300-4b7a-11eb-88b1-9a13200b884c.png)

-----------------------------------
======================

#### Autocompletion with Clang:

[vim-clang](https://github.com/justmao945/vim-clang.git) plugin brings this feature using Clang in the background to parse and complete C/C++ source files. For more information, see `:h clang.txt`.

![C source](http://justmao945.github.io/static/vim-clang/2014-01-12-async.gif)

Vim has its own set of functions to show autocompletion menus of every type which is called Omni-Completion.
The default shortcut to Omni-Completion is (in Insert mode) `<Ctrl+x><Ctrl+o>` or `<Ctrl+x><Ctrl+u>`.

Clang can read a source code (C++/C) from the terminal and parse the code to show possible suggestions for auto-completion at any defined line/column. This plugin calls clang binary in the background. One of the notable features of vim-clang is that it is ultra-reliable and ultra-portable, and also requires minimum configuration to setup. Unlike some other 'clangd' based autocompletion plugin out there, it doesn't need too extraneous steps to install and configure. Clang binary is the only dependency. The plugin manager will take care of the installation of this plugin. It works with a wide range of clang-supported compilers on different platforms with little to no extra configuration steps. It works with MinGW compiler on Microsoft Windows while some other 'clangd' based plugins will not. Python is not a compulsory requirement. Node.js is unneeded. Complex installation scripts and makefiles are not involved in the installation. Updating the plugin doesn't break anything. Works identically on every platform and compiler that clang officially supports.

What it doesn't do:

It will not autocomplete filenames so include files like `#include <boost/filesystem...`. It will not take you to the header under the cursor. It will not show you an overview of the functions, classes, structures, prototypes on a separate sidebar.

Function arguments will be shown on a window above the code, however, it will not autocomplete the arguments and parameters like some other plugins, although the users will get an overview of them on a small area above the code.

These are some very little limitations. To overcome those deficiencies, some other plugins are included as complementary elements. Inclusion of some plugins that are small, effective still keep things less complex and serve the purpose well.

Those included extra plugins are cherished by the coders across the world for many years even before clang was seen in the vicinity.

As a coder, one needs portability, reliability, and a sure-fire way of working with the instruments. This plugin with three or four extra complemental scripts makes this Vim-configuration almost unbreakable yet keeping things simple.

Autocompletion provided by clang at the command prompt:

```
clang -target x86_64-pc-windows-gnu -fsyntax-only -Xclang -code-completion-macros -Xclang -code-completion-at=main.c:11:5 main.c \
```

Internet Search: how to use clang at cmd for autocompletion of c source files
https://www.reddit.com/r/vim/comments/2wf3cn/basic_clang_autocompletion_query/

```
main.c
```

```
#include <math.h>
#include <stdio.h>
#include <windows.h>

int show_value(int *t);

int main(int argc, char **argv) {
  int i = 0, j = 0, k = 0;
  printf("Hi!\n%d, %d, %d\n", i, j, k);
  printf("%d\n", k = show_value(&j));
  sc
  system("pause");
  return 0;
}
int show_value(int *t) {
  int ptr = 70;
  int *temp;
  temp = &ptr;
  *temp = *t + *temp + ptr;
  return (*t);
}

```

```
clang: warning: \: 'linker' input unused [-Wunused-command-line-argument]
COMPLETION: scalbln : [#double#]scalbln(<#double#>, <#long#>)
COMPLETION: scalblnf : [#float#]scalblnf(<#float#>, <#long#>)
COMPLETION: scalblnl : [#long double#]scalblnl(<#long double#>, <#long#>)
COMPLETION: scalbn : [#double#]scalbn(<#double#>, <#int#>)
COMPLETION: scalbnf : [#float#]scalbnf(<#float#>, <#int#>)
COMPLETION: scalbnl : [#long double#]scalbnl(<#long double#>, <#int#>)
COMPLETION: scanf : [#int#]scanf(<#const char *restrict _Format, ...#>)
COMPLETION: scr1 : scr1
COMPLETION: scr2 : scr2
COMPLETION: scr3 : scr3
COMPLETION: scr4 : scr4
COMPLETION: scr5 : scr5
COMPLETION: scr6 : scr6
COMPLETION: scr7 : scr7
COMPLETION: scr8 : scr8
```

Another example:

```
clang++ -target x86_64-pc-windows-gnu -fsyntax-only -Xclang -code-completion-macros -Xclang -code-completion-at=main.cpp:7:11 main.cpp \
```

```
main.cpp
```

```
#include <iostream>

int main() {
    char txt[500];
    std::cout << "Test Autocompletion!";
    std::cout << "Hi!" << std::endl;
    std::c
    return 0;
}

```

```
clang++: warning: \: 'linker' input unused [-Wunused-command-line-argument]
COMPLETION: calloc : [#void *#]calloc(<#size_t _NumOfElements#>, <#size_t _SizeOfElements#>)
COMPLETION: cbegin : [#decltype(std::begin(__cont))#]cbegin(<#const _Container &__cont#>)
COMPLETION: cend : [#decltype(std::end(__cont))#]cend(<#const _Container &__cont#>)
COMPLETION: cerr : [#ostream#]cerr
COMPLETION: char_traits : char_traits<<#class _CharT#>>
COMPLETION: cin : [#istream#]cin
COMPLETION: clearerr : [#void#]clearerr(<#FILE *_File#>)
COMPLETION: clog : [#ostream#]clog
COMPLETION: codecvt : codecvt<<#typename _InternT#>, <#typename _ExternT#>, <#typename _StateT#>>
COMPLETION: codecvt_base : codecvt_base
COMPLETION: codecvt_byname : codecvt_byname<<#typename _InternT#>, <#typename _ExternT#>, <#typename _StateT#>>
COMPLETION: collate : collate<<#typename _CharT#>>
COMPLETION: collate_byname : collate_byname<<#typename _CharT#>>
COMPLETION: common_type : common_type<<#typename _Tp#>>
COMPLETION: common_type_t : common_type_t<<#typename _Tp#>>
COMPLETION: conditional : conditional<<#bool#>, <#typename#>, <#typename#>>
COMPLETION: conditional_t : conditional_t<<#bool _Cond#>, <#typename _Iftrue#>, <#typename _Iffalse#>>
COMPLETION: const_mem_fun1_ref_t : const_mem_fun1_ref_t<<#typename _Ret#>, <#typename _Tp#>, <#typename _Arg#>>
COMPLETION: const_mem_fun1_t : const_mem_fun1_t<<#typename _Ret#>, <#typename _Tp#>, <#typename _Arg#>>
COMPLETION: const_mem_fun_ref_t : const_mem_fun_ref_t<<#typename _Ret#>, <#typename _Tp#>>
COMPLETION: const_mem_fun_t : const_mem_fun_t<<#typename _Ret#>, <#typename _Tp#>>
COMPLETION: copy : [#_OI#]copy(<#_II __first#>, <#_II __last#>, <#_OI __result#>)
COMPLETION: copy : [#typename __gnu_cxx::__enable_if<__is_char<_CharT>::__value, ostreambuf_iterator<_CharT> >::__type#]copy(<#istreambuf_iterator<_CharT> __first#>, <#istreambuf_iterator<_CharT> __last#>, <#ostreambuf_iterator<_CharT> __result#>)
COMPLETION: copy_backward : [#_BI2#]copy_backward(<#_BI1 __first#>, <#_BI1 __last#>, <#_BI2 __result#>)
COMPLETION: cout : [#ostream#]cout
COMPLETION: crbegin : [#decltype(std::rbegin(__cont))#]crbegin(<#const _Container &__cont#>)
COMPLETION: crend : [#decltype(std::rend(__cont))#]crend(<#const _Container &__cont#>)
COMPLETION: ctype : ctype<<#typename _CharT#>>
COMPLETION: ctype_base : ctype_base
COMPLETION: ctype_byname : ctype_byname<<#typename _CharT#>>
COMPLETION: current_exception : [#exception_ptr#]current_exception()
```


Usage: In Insert mode, press `<Ctrl+x><Ctrl+o>` or `<Ctrl+Space>`.

Here is the video description:

![vim-clang](https://user-images.githubusercontent.com/16861933/103424482-94682280-4bd2-11eb-9db7-e05b136246eb.gif)

======================
-----------------------------------

-----------------------------------

#### Environment Variables / System Path Variable on Microsoft Windows:

***Add a program/folder to system search path:***

Some programs like [Ctags](https://github.com/universal-ctags/ctags-win32) and [Artistic Style](http://astyle.sourceforge.net/) need to be added to the PATH. Once the program (binary) folders of those utilities are added to the PATH, those programs can be accessed externally (e.g., command prompt) by any other program.

![AddToPATH2](https://user-images.githubusercontent.com/16861933/103427339-6f7daa80-4be6-11eb-81b0-b2d3dfa05ff1.gif)

Add [Splint](https://splint.org/) to PATH. It's slightly convoluted.

![Splint-PATH-001](https://user-images.githubusercontent.com/16861933/103440641-4e13d180-4c6d-11eb-85c6-b740e0359704.png)

![Splint-PATH-002](https://user-images.githubusercontent.com/16861933/103440649-59ff9380-4c6d-11eb-9007-40c1d24c21ee.png)

![Splint-PATH-003](https://user-images.githubusercontent.com/16861933/103440652-67b51900-4c6d-11eb-9a92-69714208d933.png)

![Splint-PATH-004](https://user-images.githubusercontent.com/16861933/103440659-77ccf880-4c6d-11eb-8c6a-181b961a7c32.png)

![Splint-PATH-005](https://user-images.githubusercontent.com/16861933/103440662-81566080-4c6d-11eb-805c-b0670b072770.png)

![Splint-PATH-006](https://user-images.githubusercontent.com/16861933/103440664-8ddab900-4c6d-11eb-8dc4-9fd6f3d7cdbc.png)

![Splint-PATH-007](https://user-images.githubusercontent.com/16861933/103440669-9cc16b80-4c6d-11eb-98c7-67b85e2b1f6e.png)

![Splint-PATH-008](https://user-images.githubusercontent.com/16861933/103440724-1b1e0d80-4c6e-11eb-9f59-fe7b99c00b97.png)

![Splint-PATH-009](https://user-images.githubusercontent.com/16861933/103440683-b19dff00-4c6d-11eb-8dd8-ca533d13134e.png)

-----------------------------------

----------------------------------------------------------------

**Useful weblinks:**

https://snipplr.com/ for snippets and code samples.

https://www.stackoverflow.com/ for good community-based help. (just don't ask anything there. Read questions and answers only. Any repeat question or irrelevant, inferior question may lead to an account suspension.)

https://www.cprogramming.com/ for C/C++ tutorials.

https://www.cplusplus.com/ for Standard Library functions, C/C++ documentations.

https://www.thefreecountry.com/ Links to several C/C++ libraries, programming tools etc.

Microsoft's MSDN library. Tips, tricks and C/C++ tutorials.

Wikibooks. Find free e-books on C/C++.

Wikipedia. the most extensive online free encyclopedia.

https://www.kicit.com/ for buying the books authored by Yashavant Kanetkar and other renowned C/C++ experts.

https://www.geeksforgeeks.org/ A Computer Science portal for enthusiasts.

https://www.learncpp.com/ C/C++ tutorials.

https://www.parashift.com/c++-faq-lite/ C/C++ tutorials.

https://programmers.stackexchange.com/ C/C++ tutorials.

https://www.codeproject.com/KB/cpp/ C/C++ tutorials.

https://www.hermetic.ch/cfunlib.htm C/C++ tutorials.

https://cplus.about.com/ C/C++ tutorials.

https://www.programmersheaven.com/ C/C++ tutorials.

https://www.tenouk.com/ C/C++ tutorials.

https://www.studiesinn.com/ C/C++ tutorials.

https://www.learnconline.com/2010/03/introduction.html C/C++ tutorials.

https://bbb-letuscsolutions.blogspot.com/ for solutions to Yashavant Kanetkar's books.

https://www.sourcecodesworld.com/ find many solved problems.

https://wiki.answers.com/Q/C_Program_to_calculate_factorial miscellaneous.

https://wiki.answers.com/ miscellaneous.

----------------------------------------------------------------

**Useful Vim Books:**

https://learnvimscriptthehardway.stevelosh.com/ Learn Vimscript the Hard Way is a book for users of the Vim editor who want to learn how to customize Vim.

https://devhints.io/vimscript Vim scripting cheatsheet.

Hacking Vim, by "Kim Schulz"

vi-vim-cheat-sheet-and-tutorial.pdf, from www.viemu.com

OReilly->Learning the vi and Vim Editors, by "Arnold Robbins, Elbert Hannah, and Linda Lamb"

----------------------------------------------------------------

**Useful C/C++ Books:**

**C Programming:**

https://www.programiz.com/c-programming Learn C Programming.

__"Let Us C"__ by _Yashavant P. Kanetkar_; nothing can be better than this book.
__"Understanding Pointers in C"__ by _Yashavant P. Kanetkar_ is a must-have book along with __"Let Us C"__. __"Data Structures Through C"__ by _Yashavant P. Kanetkar_; complete C learning with this book.

These three books above are the whole learning course divided into three parts.

First Read __"Let US C"__, then __"Understanding Pointers in C"__, and then __"Data Structures Through C"__,
to complete the entire course. You will perform better than anybody.

__C Programming__ (download from wikibooks)

__A Little C Primer__ (download from wikibooks)

https://www.cprogramming.com/tutorial/c-tutorial.html?inl=nv C Tutorial.

https://cplusplus.com/

**C++ Programming:**

https://www.programiz.com/cpp-programming Learn C++ Programming.

__Object-Oriented Programming with C++ | 8th Edition Paperback – 24 September 2020__ or Newer, by _E Balagurusamy_.
ISBN-10 : 9389949181
ISBN-13 : 978-9389949186

__Sams Teach Yourself C++ in 21 Days Paperback__
ISBN-10:  0672329417 ISBN-13: 9780672329418
ISBN-10 : 0672327112
ISBN-13 : 978-0672327117
(Warning: The page count is somewhat high, it's around 937 pages.)

https://www.geeksforgeeks.org/c-plus-plus/ Geeks-for-Geeks C++ courses.

__Jumping into C++__ by _Alex Allain_.
ISBN-10 : 0988927802
ISBN-13 : 978-0988927803

__Exploring C++__ by _Ray Lischner_.
ISBN-13 (pbk): 978-1-59059-749-1
ISBN-10 (pbk): 1-59059-749-4
ISBN-13 (electronic): 978-1-4302-1895-1

__Debugging with gdb__.
https://shop.fsf.org/books-docs/debugging-gdb-gnu-source-level-debugger-v-731

https://www.eecs.umich.edu/courses/eecs373/readings/Debugger.pdf

http://www.winprog.org/tutorial/ theForger's Win32 API Programming Tutorial.

__Programming Windows 5e (Microsoft Programming Series) Hardcover by Charles Petzold__.
ISBN-10 : 157231995X
ISBN-13 : 978-1572319950

https://www.cprogramming.com/tutorial/c++-tutorial.html?inl=nv C++ Tutorial.

https://cplusplus.com/

Extra Books:

__Programming Windows__ by _Charles Petzold_, for Win32 GUI programming on Windos OS.

__Windows via C/C++__ by _Jeffrey Richter_.

__Go Embedded__ by _Yashavant P. Kanetkar_, for Atmel AVR microcontroller programming.


----------------------------------------------------------------

**Applications:**

Without the following applications, it would have never been possible to draft this Readme file. Many thanks to their developers!

[ScreenToGif](https://github.com/NickeManarin/ScreenToGif)

[Greenshot](https://getgreenshot.org/)

[Inkscape](https://inkscape.org/)

[GIMP](https://www.gimp.org/)

[GIMP](https://www.gimp.org/) made it possible to create the GIF animations. [Inkscape](https://inkscape.org/) helped painting vector graphic images like arrow keys etc. The [keyboard](https://openclipart.org/detail/326617/keyboard) shown was designed with Inkscape.

[Adobe Photoshop](https://www.adobe.com/products/photoshop.html)

[Vim](https://www.vim.org/) The ubiquitous text editor.

[Notepad2-mod](https://xhmikosr.github.io/notepad2-mod/) A modified version (fork) of Notepad2.

[Notepad++](https://notepad-plus-plus.org/)

[Mousepad XFCE Text Editor](https://github.com/codebrainz/mousepad) A simple text editor for the Xfce desktop environment.

----------------------------------------------------------------

### Plugin Management

[vim-plug](https://github.com/junegunn/vim-plug.git) takes care of the plugin management once the required plugins are listed on the .vimrc file.

In this Vim configuration, `.vimrc` calls another script `$HOME/.vimdotcommon/.vimrc2.vim`.

Find it: `%userprofile%\.vimdotcommon\.vimrc2.vim` or `~/.vimdotcommon/.vimrc2.vim`.

A dedicated section is there to list the necessary plugins. The listed plugins will be installed and updated from GitHub repositories when the following commands will be issued `:PlugInstall` and `:PlugUpdate`.

[vim-plug](https://github.com/junegunn/vim-plug.git) makes it easy to deal with plugins when it finds a line containing the word `Plug` at the beginning of a line followed by a link to the respective GitHub repository surrounded with single quotes `''`. For example: `Plug 'https://github.com/junegunn/vim-plug.git'` will install [vim-plug](https://github.com/junegunn/vim-plug.git) itself (although it's unnecessary since it's first loaded from the `autoload` directory).

Commenting out the line will remove the plugin if the command `:PlugClean` is issued. Delete the line, it will have the same effect. Write a line like `Plug 'https://link-to-the-github-repo-of-the-plugin.git'`, and issue the command `:PlugInstall`, the plugin you need will be installed.

You can install as many plugins as you want as long as a plugin you are going to instal doesn't create conflict with the existing plugins (keymaps etc.).

You can also remove existing plugins, but I will strongly advise you against doing so. Very minimal and vital plugins are included. Use them, you won't regret it.

----------------------------------------------------------------

## A brief on Vim and C/C++

For any C fanatic, the reason for the C enthusiasm is axiomatic. C will probably never be outdated. As of writing this Readme file, it's nighttime here. We are accustomed to working with a set of technology we are using at this moment. The technology may change during midnight. Jokes apart, where the technology shifts all around the year, making it somewhat difficult for the programmers to get acquainted with new programming languages which compel them to constantly update their skill to stay relevant in the market, C stays the same rock-solid. C evolves into a cut above the earlier standards. However, when it comes to developing and maintaining performance-critical applications with consistency, no language comes close to C. It's the choice of the microcontroller programmers, device driver writers, operating system developers, compiler and interpreter designers. For the performance-critical applications, those demand squeezing out the last drop of the juice from the host device, C is the only choice. The only limitation is imagination. C++ is not too different if considered as the superset of C. C never makes your knowledge obsolete thus pays for the time investment. So is Vim. Vim never changes, only improves over time. The founder of Vim has an inviolable affirmative user support policy. He doesn't want to pose a threat to the users where they will have to unlearn and re-learn something for which they have invested their time in decades. So learning Vim and C/C++ makes the steep learning curve worth the trouble. They both are like iron, the fundamental and indispensable element that builds up the core of every newer engine. Even if technology advances, iron will remain essential. This configuration in combination with C/C++ and Vim and a wide array of critical external utilities provides the reliability we can find nowhere else. You can rest assured that your tools are evergreen and unbreakable. So that Tulu who is a cute reliable soft-toy puppet. 🐕

----------------------------------------------------------------

## My two cents for the Vim exploiters:

![ICCF in Uganda](https://www.iccf-holland.org/images/school.jpg)

The very essence of morality, principalities, ethical rights to humans and creatures alike in a society is dependent on the seed sowed by our predecessors. Education and sustainability for underprivileged children is a must for building the foundation of a nation. One day, they will grow up and move this society forward. Teach them to distinguish right from the wrong, they will carry it to their future. We all should stand up against poverty, malnutrition, corruption, brutality, animal-cruelty, child labour, slavery, lack of infrastructure developments, and so on and on. It all depends on how well the children of a certain section of society was nurtured. It's not a mission to be fought by one-man-army. We all should stand together and join the fight. Bram Moolenaar took a praiseworthy approach by providing care for the underprivileged kids of Uganda. I believe his organisation should expand its reach all over the world. He provides medical care, food, education to those children who have been betrayed by their fate. We still have been left with some hope. Bram stood up. Now we all should come forward. Vim will remain the most lethal weapon in your arsenal forever. Bram will maintain Vim. Pay your tribute. Make a small donation to ICCF.

Here it is: [ICCF](https://en.wikipedia.org/wiki/ICCF_Holland)

Cheers and HAPPY VIMMING!

----------------------------------------------------------------

#### After an hour-long study, REFRESH your mood!

https://youtu.be/Gi7vKjm32V4
