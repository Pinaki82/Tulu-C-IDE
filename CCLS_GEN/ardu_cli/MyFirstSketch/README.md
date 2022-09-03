# Arduino-CLI with .lvimrc

## Arduino-CLI Installation

Open up a terminal emulator and go to your $HOME directory.

```
cd ~/
```

If you have brew package manager on your Linux system (not necessary), you can install Arduino-CLI from the Brew Package Manager. We won't be using the brew package of Arduino-CLI. Instead, we will follow the official method.

```
brew install arduino-cli
```

To uninstall the brew package,

```
brew uninstall arduino-cli
```

Do you have the BASH Shell on your system? Probably, yes.

Open up a terminal emulator and type the following command to install Arduino-CLI.

> https://arduino.github.io/arduino-cli/0.26/installation/

```
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
```

To uninstall (don't do that),

```
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh | uninstall
```

Verify that it has been installed properly.

```
arduino-cli
```

Arduino will place a folder `bin` into your `$HOME` directory. Enter `~/bin`

However, Arduino-CLI-SDK will be installed in `$HOME/.arduino15/`. The folder `$HOME/bin` will contain only the program `arduino-cli`. All other files will be placed into `$HOME/.arduino15/`.

```
cd ~/bin
```

You'll need shell autocompletion files so that you can work with the Arduino SDK in the terminal. I'm not talking about GVim's code completion. We will come to it later.

Generate files for two of the popular shells 1) Bash and 2) Fish.

Permit `arduino-cli` to execute.

```
chmod +x arduino-cli
```

```
./arduino-cli completion bash > arduino-cli.sh
```

Switch to the fish shell.

```
fish
```

```
./arduino-cli completion fish > arduino-cli.fish
```

Copy the file `arduino-cli.fish` to `~/.config/fish/completions/` so the Fish shell can autocomplete Arduino commands you'll type in the terminal.

```
mkdir -p ~/.config/fish/completions/
```

```
cp ~/bin/arduino-cli.fish ~/.config/fish/completions/
```

Exit the Fish shell.

```
exit
```

How will Arduino know that you've installed it?

Drop the following lines to your `.bash_aliases` or `.bashrc`.

```
any_gui_text_editor_geany_mousepad_gedit_kate ~/.bash_aliases
```

Then,

```
# Arduino-CLI
export PATH="$HOME/bin/:$PATH"
# arduino-cli completion bash > arduino-cli.sh
source ~/bin/arduino-cli.sh
# avrdude (for uploading HEX files to boards)
# ln -s ~/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/avrdude ~/.local/bin/avrdude
export PATH="$HOME/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/:$PATH"
```

The `#` character is used here to write comments. Comments in codes are ignored.

Do the same to the Fish shell.

Edit the file `~/.config/fish/config.fish`.

```
any_gui_text_editor_geany_mousepad_gedit_kate ~/.config/fish/config.fish
```

```
# Arduino-CLI
set PATH $PATH "$HOME/bin/:$PATH"
# arduino-cli completion fish > arduino-cli.fish
# mkdir -p ~/.config/fish/completions/
# cp ~/bin/arduino-cli.fish ~/.config/fish/completions/
export PATH
# avrdude (for uploading HEX files to boards)
# ln -s ~/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/avrdude ~/.local/bin/avrdude
export PATH="$HOME/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/:$PATH"
export PATH
```

You'll need 'Avrdude' to upload compiled codes to microcontroller boards. 

The shells mentioned still don't have a clue of the location of that 'avrdude' program. The shells don't know where they should look for `avr-gcc` and `avr-g++` yet.

To make those three programs (`avrdude`, `avr-gcc` and `avr-g++`) available to the shells, you'll have to create symbolic links (commonly referred to as symlinks). Add the links to the programs `avr-gcc` , `avr-g++`, and `avrdude` from the 'avr-gcc toolchain' to `/usr/bin`. The link to `avrdude` should go to `$HOME./local/bin`.

```
sudo ln -s ~/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-gcc /usr/bin/avr-gcc
```

```
sudo ln -s ~/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-g++ /usr/bin/avr-g++
```

```
ln -s ~/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/avrdude ~/.local/bin/avrdude
```

Now, Bash and Fish can find those programs.

Update the core toolchains and libraries of the SDK.

```
arduino-cli core update-index
```

Generate an `init` file for the configuration.

```
arduino-cli config init
```

Install some Arduino boards.

For example, if we want to find the board Arduino Uno R3,

```
arduino-cli core search uno
```

`uno` is the board identifier. Visit Arduino's official site to get more information about other supported boards.

The output should look somewhat similar to this:

```
Downloading index: package_index.tar.bz2 downloaded                             
ID              Version Name                  
arduino:avr     1.8.5   Arduino AVR Boards    
arduino:megaavr 1.8.7   Arduino megaAVR Boards
```

In our example, we are looking for the Uno board, not the Arduino Mega board. So let's pick the appropriate board and install support for it. It is generally abbreviated 'installing boards'.

```
arduino-cli core install arduino:avr
```

Check the boards you have on your machine.

```
arduino-cli core list
```

Output:

```
ID          Installed Latest Name              
arduino:avr 1.8.5     1.8.5  Arduino AVR Boards
```

```
arduino-cli board list
```

Output (we haven't connected the board yet):

```
Port       Protocol Type        Board Name FQBN Core
/dev/ttyS0 serial   Serial Port Unknown  
```

Time to create an Arduino sketch.

Go to any preferred location in your hard drive. R-click inside a directory and choose to open a terminal in that location. For example, if the name you want to have for your first Arduino sketch is MyFirstSketch, you'll have to type MyFirstSketch after `arduino-cli sketch new`.

```
arduino-cli sketch new MyFirstSketch
```

Step one directory level back. We will have to compile the sketch. Do not try to compile if you are inside the folder where the `*.ino` is located. One thing to notice, the sketch name should be the same as the folder name in which it has been placed.

Compile the sketch:

```
arduino-cli compile --fqbn arduino:avr:uno MyFirstSketch
```

Another compile command example for the Arduino Diecimila boards:

```
arduino-cli compile --fqbn arduino:avr:diecimila:cpu=atmega328 MyFirstSketch
```

However, you'll need the compiler output files.

```
arduino-cli compile --fqbn arduino:avr:uno MyFirstSketch --output-dir ~/MyFirstSketch/compilerout
```

The compiler will produce machine-readable binary files into the folder 'compilerout'.

> Referenced: https://stackoverflow.com/questions/57429802/is-there-a-way-to-use-arduino-cli-to-compile-sketch-ino-to-a-bin-file

The programs you will require:

- avrdude
- avrdude-doc
- dfu-programmer

To know the detailed installation procedure and compilation options, visit the following pages:

https://arduino.github.io/arduino-cli/0.26/installation/

https://arduino.github.io/arduino-cli/0.26/command-line-completion/

https://arduino.github.io/arduino-cli/0.26/getting-started/

---

## Autocompletion

GVim's autocompletion will be provided by [vim-lsp](https://github.com/prabirshrestha/vim-lsp.git). It utilises [LLVM](https://llvm.org/) [Clang](https://clang.llvm.org/)'s backend LSP ([Language Server Protocol](https://en.wikipedia.org/wiki/Language_Server_Protocol)) to provide completion on the fly as you type. [vim-lsp](https://github.com/prabirshrestha/vim-lsp.git) needs Clang in the background, so Clang must be found on the system. [vim-lsp](https://github.com/prabirshrestha/vim-lsp.git) requires some basic information to show the search queries. This information must be loaded from two configuration files, namely, `.ccls` and `compile_flags.txt`.
A basic `.ccls` file for Arduino-CLI should look like this:

```
clang
%c -std=c11
%cpp -std=c++17
%cpp -stdlib=libc++
%cpp -stdlib=libstdc++
%h %hpp --include=Global.h
-Iinc
-DMACRO


%c -Wall
%c -Weffc++
%c -Wextra
%c -pedantic
%c -Wfatal-errors
%c -Winit-self
%c -Wnon-virtual-dtor
%c -Winline
%c -Wmissing-declarations
%c -Wmissing-include-dirs
%c -Wundef
%c -Wredundant-decls
%c -Wfloat-equal
%c -Wmain
%c -Wunreachable-code
%c -Wshadow
%c -Wcast-align
%c -Wswitch-default
%c -Wswitch-enum
%c -Wstrict-prototypes
%c -Wmissing-prototypes
%c -Wmissing-declarations
%c -Wnested-externs
%c -Wformat=2
%c -Wformat-security
%c -Wformat-signedness
%c -Wformat-y2k
%c -Wconversion
%c -Weverything
%c -ferror-limit=0
%c -ftemplate-backtrace-limit=0

%c --sysroot=$HOME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/

%c -target
%c avr
%c -mcpu=atmega328p


-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/plugin/include
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/plugin/include/c-family
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/plugin/include/config
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/plugin/include/config/avr
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/plugin/include/cp
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/include-fixed
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/include
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/install-tools
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/install-tools/include
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/avr/include
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/avr/include/compat
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/avr/include/util
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/avr/include/avr
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/avr/include/sys
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/include/libiberty
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/x86_64-pc-linux-gnu/avr/include
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/bootloaders/stk500v2
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/bootloaders/caterina-Arduino_Robot
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/bootloaders/caterina
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/bootloaders/optiboot
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/bootloaders/caterina-LilyPadUSB
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/bootloaders/gemma
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/mega
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/leonardo
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/yun
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/standard
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/circuitplay32u4
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/robot_motor
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/eightanaloginputs
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/robot_control
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/ethernet
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/micro
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/gemma
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/cores/arduino
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/drivers/FTDI USB Drivers
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/libraries/Wire/src/utility
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/libraries/Wire/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/libraries/EEPROM/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/libraries/SPI/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/libraries/HID/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/libraries/SoftwareSerial/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/atmegaxxu2/arduino-usbserial
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/atmegaxxu2/arduino-usbserial/Lib
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/atmegaxxu2/arduino-usbserial/Board
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/atmegaxxu2/arduino-usbdfu
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/atmegaxxu2/arduino-usbdfu/Board
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/BOARDS/ARDUINO
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/BOARDS/EVK1105
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/BOARDS
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/UTILS
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/UTILS/DEBUG
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/UTILS/PREPROCESSOR
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/UTILS/LIBS/NEWLIB_ADDONS/INCLUDE
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/LWIP/lwip-port-1.3.2/HD/if/include/netif
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/LWIP/lwip-port-1.3.2/HD/if/include
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/LWIP/lwip-port-1.3.2/HD/if/include/arch
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/LWIP/lwip-1.3.2/src/include/netif
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/LWIP/lwip-1.3.2/src/include/lwip
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/LWIP/lwip-1.3.2/src/include/ipv4/lwip
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/MEMORY/CTRL_ACCESS
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/DELAY
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/EBI/SMC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/INTC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/USART
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/CPU/CYCLE_COUNTER
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/TC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/EIC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/FLASHC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/PM
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/SPI
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/GPIO
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/RTC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/PDCA
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/COMPONENTS/WIFI/HD
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/COMPONENTS/MEMORY/DATA_FLASH/AT45DBX
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/CONFIG
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/BOARDS/ARDUINO
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/BOARDS/EVK1105
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/BOARDS
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/UTILS
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/UTILS/DEBUG
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/UTILS/PREPROCESSOR
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/UTILS/LIBS/NEWLIB_ADDONS/INCLUDE
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/SERVICES/MEMORY/CTRL_ACCESS
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/DRIVERS/INTC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/DRIVERS/USART
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/DRIVERS/FLASHC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/DRIVERS/PM
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/DRIVERS/SPI
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/DRIVERS/GPIO
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/COMPONENTS/MEMORY/DATA_FLASH/AT45DBX
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/CONFIG
```

This file contains some compilation flags required by '[clangd](https://clangd.llvm.org/)', Clang's Language Server backend, also the list of directories containing Arduino and [AVR-GCC](https://gcc.gnu.org/wiki/avr-gcc)'s header files.

And the same goes for `compile_flags.txt`. Here you have one instance of it.

```
-Wall
-Weffc++
-Wextra
-pedantic
-Wfatal-errors
-Winit-self
-Wnon-virtual-dtor
-Winline
-Wmissing-declarations
-Wmissing-include-dirs
-Wundef
-Wredundant-decls
-Wfloat-equal
-Wmain
-Wunreachable-code
-Wshadow
-Wcast-align
-Wswitch-default
-Wswitch-enum
-Wstrict-prototypes
-Wmissing-prototypes
-Wmissing-declarations
-Wnested-externs
-Wformat=2
-Wformat-security
-Wformat-signedness
-Wformat-y2k
-Wconversion
-Weverything
-ferror-limit=0
-ftemplate-backtrace-limit=0

--sysroot=$HOME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/
-target
avr
-mcpu=atmega328p


-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/cores/arduino/
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/plugin/include
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/plugin/include/c-family
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/plugin/include/config
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/plugin/include/config/avr
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/plugin/include/cp
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/include-fixed
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/include
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/install-tools
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/lib/gcc/avr/7.3.0/install-tools/include
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/avr/include
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/avr/include/compat
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/avr/include/util
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/avr/include/avr
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/avr/include/sys
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/include/libiberty
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/x86_64-pc-linux-gnu/avr/include
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/bootloaders/stk500v2
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/bootloaders/caterina-Arduino_Robot
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/bootloaders/caterina
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/bootloaders/optiboot
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/bootloaders/caterina-LilyPadUSB
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/bootloaders/gemma
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/mega
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/leonardo
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/yun
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/standard
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/circuitplay32u4
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/robot_motor
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/eightanaloginputs
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/robot_control
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/ethernet
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/micro
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/variants/gemma
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/cores/arduino
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/drivers/FTDI USB Drivers
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/libraries/Wire/src/utility
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/libraries/Wire/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/libraries/EEPROM/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/libraries/SPI/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/libraries/HID/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/libraries/SoftwareSerial/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/atmegaxxu2/arduino-usbserial
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/atmegaxxu2/arduino-usbserial/Lib
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/atmegaxxu2/arduino-usbserial/Board
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/atmegaxxu2/arduino-usbdfu
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/atmegaxxu2/arduino-usbdfu/Board
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/BOARDS/ARDUINO
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/BOARDS/EVK1105
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/BOARDS
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/UTILS
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/UTILS/DEBUG
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/UTILS/PREPROCESSOR
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/UTILS/LIBS/NEWLIB_ADDONS/INCLUDE
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/LWIP/lwip-port-1.3.2/HD/if/include/netif
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/LWIP/lwip-port-1.3.2/HD/if/include
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/LWIP/lwip-port-1.3.2/HD/if/include/arch
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/LWIP/lwip-1.3.2/src/include/netif
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/LWIP/lwip-1.3.2/src/include/lwip
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/LWIP/lwip-1.3.2/src/include/ipv4/lwip
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/MEMORY/CTRL_ACCESS
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/SERVICES/DELAY
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/EBI/SMC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/INTC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/USART
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/CPU/CYCLE_COUNTER
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/TC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/EIC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/FLASHC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/PM
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/SPI
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/GPIO
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/RTC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/DRIVERS/PDCA
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/COMPONENTS/WIFI/HD
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/SOFTWARE_FRAMEWORK/COMPONENTS/MEMORY/DATA_FLASH/AT45DBX
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifiHD/src/CONFIG
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/BOARDS/ARDUINO
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/BOARDS/EVK1105
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/BOARDS
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/UTILS
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/UTILS/DEBUG
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/UTILS/PREPROCESSOR
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/UTILS/LIBS/NEWLIB_ADDONS/INCLUDE
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/SERVICES/MEMORY/CTRL_ACCESS
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/DRIVERS/INTC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/DRIVERS/USART
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/DRIVERS/FLASHC
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/DRIVERS/PM
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/DRIVERS/SPI
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/DRIVERS/GPIO
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/SOFTWARE_FRAMEWORK/COMPONENTS/MEMORY/DATA_FLASH/AT45DBX
-I/home/YOUR_USERNAME/.arduino15/packages/arduino/hardware/avr/1.8.5/firmwares/wifishield/wifi_dnld/src/CONFIG
```

Notice that the lines `%c --sysroot=$HOME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/` and `--sysroot=$HOME/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/` are optional.

Next, have a look at the following lines in `.ccls` and `compile_flags.txt` (the latter being essentially the same, without the `%c` flag):

```
%c -target
%c avr
%c -mcpu=atmega328p
```

```
-target
avr
-mcpu=atmega328p
```

It may vary.

In the case of PlatformIO SDK, the lines will look like this,

```
%c --target=avr
%c -mcpu=atmega328p
```

```
--target=avr
-mcpu=atmega328p
```

respectively.

To get an idea about the supported microcontroller architecture and specific MCU (microcontroller unit), type these commands given below in a terminal emulator. In this case, the `target` is the `avr` controllers. `-mcpu=atmega328p` specifies the precise MCU. The LSP functionality is provided by 'clang', so we must ensure the compiler for a controller is supported by 'clang'.

```
llvm-config --host-target
llc -march=armeb -mattr=help
llc -march=arm -mattr=help
llc --version | grep Default
llc --version | grep armeb
llc --version | grep Default
clang -v 2>&1 | grep Target
clang-11 -print-targets
clang -print-targets
llc -march=armeb -mattr=help
clang --target=avr -mmcu=atmega328p
llc -march=avr -mattr=help
```

Use +feature to enable a feature, or -feature to disable it.
For example, llc -mcpu=mycpu -mattr=+feature1,-feature2

> Referenced:
> 
> https://lists.llvm.org/pipermail/llvm-dev/2020-March/140262.html

> https://lists.llvm.org/pipermail/llvm-dev/2020-March/140320.html

> https://stackoverflow.com/questions/15036909/clang-how-to-list-supported-target-architectures

Here's the million-dollar question. Will I have to manually find all the directories containing AVR-GCC's header files and keep track of them in a note every time I update/remove a particular board?

I encountered the same situation and asked myself the same question. The answer is simple. 

> NOTE: Find a program 'arduheaders'. It's already been furnished. Find it in the 'CCLS_GEN' folder. Read the instructions written under comments, compile the code and install the program.

Run the program 'arduheaders' inside the directory containing the sketch file (*.ino) with appropriate options. R-click inside a directory and open a terminal there. In our case, the board is Arduino Uno R3 which essentially contains an AVR MCU, and the specific MCU model is ATMEGA328P. Arduino-CLI is typically installed in the $HOME folder. The folder of the SDK is `.arduino15` as of today. By now, we know all the information we need to generate a `.ccls` and a `compile_flags.txt`.

So, in the terminal, type:

```
arduheaders avr -mcpu=atmega328p $HOME/.arduino15/ a t
```

The arguments 'arduheaders' takes:

0) The name of the prog. itself (automatic. you won't be able to provide this argument)

1) `avr`/`arm`: The name of the MCU architecture

2) `-mcpu=atmega328p`: The flag that tells the LSP to provide completion for a specific MCU model. Here, it is ATMEGA328p

3) `$HOME/.arduino15/`: The location of the SDK.
   
   'arduheaders' will find header files in that location and sub-directories.

4) `a` or `p`: `a` means Arduino-CLI SDK. `p` means PlatformIO-Core-CLI SDK

5) `t`: The flag `t` will generate 'tags' with `ctags` in the SDK's 'include' directories

The last argument is a newline char reciprocated as a NULL terminator.

If you're running Arduino-CLI for the first time and didn't create 'tags' files in the SDK's 'include' directories, use the `t` option. After updating/removing board support, run 'arduheaders' with the `t` option. Otherwise, you won't need to generate 'tags' file in the system directories (treat the SDK's directories as if they were your system's directories). In that case, when you don't want to generate 'tags', type `n` or any other character, just not 't'.

'arduheaders' will put three files in your sketch folder.

1) ccls.txt
2) 0compile_flags.txt
3) arduvim-tagspath.txt

Rename those files to

1) .ccls
2) compile_flags.txt

Then, copy all the contents of the files 'arduvim-tagspath.txt' to the file `.lvimrc`.

You may ask me, what is the purpose of generating 'tags' files nowadays when we are getting the completion hint from the LSP? Well, you can use those ctags database files with 'code_complete.vim' plugin. Do not generate 'tags' if you don't need anything related to old-school 'ctags'. It's optional.

## Edit your sketches with GVim:

GVim can recognise `*.ino` files as C++ files. The problem is however, that it is hard to tell the LSP plugins to recognise the `*.ino` files as C++ files. Solution? Rename the file, then edit. Before compiling the code, rename the sketch again. INO --> CPP, then, CPP --> INO. Sorry! It's something not in our control at the moment.

For editing -> rename

```
mv MyFirstSketch/MyFirstSketch.ino MyFirstSketch/MyFirstSketch.cpp
```

Before compilation -> rename

```
mv MyFirstSketch/MyFirstSketch.cpp MyFirstSketch/MyFirstSketch.ino
```

Now, try to edit your sketch. Type something and see if the LSP plugin gives you any completion hints.

![Screenshot at 18-06-56](https://user-images.githubusercontent.com/16861933/188205843-3f6328d5-8ea4-4b30-bca4-dfdae5be3f4e.jpg)

Here, if you roll your mouse pointer over the include section, you'll notice that it says 'Arduino.h' is not found. It's not vim-lsp's fault. I commented out the line `Plug 'https://github.com/dense-analysis/ale.git'` in my Vim config file `.vimrc2.vim` to prevent it from being loaded at startup. The notification disappeared.

![Screenshot at 18-24-04](https://user-images.githubusercontent.com/16861933/188205843-3f6328d5-8ea4-4b30-bca4-dfdae5be3f4e.jpg)

'Arduino.h' includes 'HardwareSerial.h' so the hint for the functions in 'HardwareSerial.h'  is shown by the LSP. The two angled brackets `>>` you see tell us that the completion hint is available for the typed string and the line is being edited.

ALE is a great plugin for error checking. The problem with ALE is it doesn't read from the `.ccls` file, and it does fully support the `compile_flags.txt` method. All it wants is a compile_commands.json file which can only be generated with special tools like CMake. In our case, which is not possible. We are not using CMake.

You don't have to disable ALE. However, you don't have to worry either. 'vim-lsp' also provides code error checking. You'll be notified if your code contains any potential errors.

You always have the choice to download the Arduino-IDE in an AppImage container. Do you want it? Get it here: https://www.arduino.cc/en/software
Nevertheless, you'll rarely need the Arduino-IDE.

Use the supplied folder as a template. You can start from there.

## COPYRIGHT NOTICE:

> COPYRIGHT NOTICE:
> 
> Code files and all other files
> 
> in the directory 'MyFirstSketch' are distributed under
> the terms of the MIT-0 License (MIT No Attribution license),
> unless or otherwise stated. A copy of the MIT-0 License can
> be found at https://spdx.org/licenses/MIT-0.html
> or, https://opensource.org/licenses/MIT-0.
> All codes in this directory 'MyFirstSketch'
> without any copyright notice inside (under comment blocks)
> should be treated as MIT-0 licenced,
> although TULU-C-IDE is distributed under the BSL (https://www.boost.org/users/license.html).
> 
> The directory 'MyFirstSketch' might contain cached copies
> of webpages and PDF files collected from various sources that are
> protected by International Copyright Laws.
> The link to the documents can be found either in the files (PDF),
> including the copyright notices or, the cached HTML files should
> be enough to visit the parent HTTPS links for finding copyright
> notices regarding the documents.
> The distributor of TULU-C-IDE doesn't claim to be the creator or
> the owner of any such documents.

#### MIT-0 (The MIT No Attribution license):

```
MIT No Attribution

Copyright <YEAR> <COPYRIGHT HOLDER>

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```