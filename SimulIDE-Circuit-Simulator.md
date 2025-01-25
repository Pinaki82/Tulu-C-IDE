# SimulIDE Circuit Simulator

![SimulIDE Logo](https://private-user-images.githubusercontent.com/16861933/406678309-f2ec0c2f-d0b3-489f-8770-c2ac24eac46f.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzc4Mjc2MDgsIm5iZiI6MTczNzgyNzMwOCwicGF0aCI6Ii8xNjg2MTkzMy80MDY2NzgzMDktZjJlYzBjMmYtZDBiMy00ODlmLTg3NzAtYzJhYzI0ZWFjNDZmLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTAxMjUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwMTI1VDE3NDgyOFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWE0YzRhMzM5YTA5ODAwOTRkOTQ5NGE4NDAzNzU5NDJkNGM5NDhlYjNkMGUzMTgyMGQ1YzlhMGZjZGRkYWQ2OGEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.f3d0SZLr32DGTNeRS4smnVtLOQEH02_kGC42Rle5Zk0)

## Overview

[SimulIDE](https://simulide.com/p/) is a real-time electronic circuit simulator. This guide provides a comprehensive installation and setup tutorial for Linux users, specifically tested on Debian Bookworm.

Quick Start Guide: [Quick start guide for SimulIDE as an Arduino simulator - Github personal blog](https://pcotret.github.io/simulide/)

Referenced:

> https://www.arduino.cc/en/software
> 
> [GitHub - arduino/arduino-cli: Arduino command line tool](https://github.com/arduino/arduino-cli)
> 
> [Installation - Arduino CLI](https://arduino.github.io/arduino-cli/1.1/installation/)
> 
> [Getting started - Arduino CLI](https://arduino.github.io/arduino-cli/1.1/getting-started/)

## Prerequisites

### Arduino CLI Installation

Install Arduino CLI using the following command:

```bash
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=~/.local/bin sh
```

Note: The binary will be located at `~/.local/bin/arduino-cli`.

### Arduino Core Setup

Update the Arduino core and install the AVR microcontroller toolchain:

```bash
arduino-cli core update-index
arduino-cli config init
arduino-cli core install arduino:avr
arduino-cli core list
```

## List installed toolchains:

```bash
arduino-cli board list
```

### Shell Completion Setup

#### Bash Completion

```bash
cd ~/
bash
arduino-cli completion bash > arduino-cli.sh
sudo mv arduino-cli.sh /etc/bash_completion.d/
exit
```

#### Fish Shell Completion

```bash
fish
cd ~/
arduino-cli completion fish > arduino-cli.fish
mkdir -p ~/.config/fish/completions/
mv arduino-cli.fish ~/.config/fish/completions/
exit
```

## Arduino Legacy IDE Installation

SmulIDE supports Arduino Legacy versions (1.8.X). Download version 1.8.19 from: https://downloads.arduino.cc/arduino-1.8.19-linux64.tar.xz

Extract the archive to your preferred directory (e.g., `/mnt/hdd2/PortablePrograms/arduino-1.8.19/`).

## Dependencies Installation

Install required dependencies:

```bash
yes | sudo apt install libqt5core5a libqt5gui5 libqt5xml5 libqt5svg5 libqt5widgets5 libqt5concurrent5 libqt5multimedia5 libqt5multimedia5-plugins libqt5serialport5 libqt5script5 libelf1
```

## SimulIDE Installation

1. Download SimulIDE from: [SimulIDE Downloads](https://simulide.com/p/downloads/)
2. Extract to a preferred directory
3. Make the binary executable:

```bash
chmod +x simulide
```

## Project Setup

### Loading a Sketch

![Load Sketch](https://private-user-images.githubusercontent.com/16861933/406678479-1856f878-4cfe-4585-82d5-c5487473cadc.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzc4Mjc3MzEsIm5iZiI6MTczNzgyNzQzMSwicGF0aCI6Ii8xNjg2MTkzMy80MDY2Nzg0NzktMTg1NmY4NzgtNGNmZS00NTg1LTgyZDUtYzU0ODc0NzNjYWRjLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTAxMjUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwMTI1VDE3NTAzMVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWIyNGFlNjM3Njg1MzAyOTNjMzE1ZWY2YjNiYzNkOGMzYzg4ZjNmMmRiYjVjOGZlNTBjYTViMDY3OWM4NTg3OWYmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.t2YTANePZ7I0zYz5HbNOSJrCc98MISpPUS9bPikrNfc)

1. Load an existing Arduino sketch (*.ino)
2. Create/Load a corresponding circuit file (*.sim1)

Load a circuit:

![Load a circuit](https://private-user-images.githubusercontent.com/16861933/406679345-3916475d-b340-48e6-8c1f-7c62928798d2.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzc4Mjg1MzMsIm5iZiI6MTczNzgyODIzMywicGF0aCI6Ii8xNjg2MTkzMy80MDY2NzkzNDUtMzkxNjQ3NWQtYjM0MC00OGU2LThjMWYtN2M2MjkyODc5OGQyLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTAxMjUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwMTI1VDE4MDM1M1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTVkZGRlNGIzYmM0NzU2NTc4NGQ1NDViODNiYjFmMjViY2U0MmQ0ZTM0NTlkMjAyYmRiZWRlN2UyNWIzNDZlMzAmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.LzXIjkFISFq2qFND3-c08IdHrFXXiyvOhHY2h0Iy1Yg)

### Compiler Configuration

![Compiler Settings](https://private-user-images.githubusercontent.com/16861933/406678488-92b3774c-0217-4db4-a1c7-120f7778a393.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzc4Mjc3MzEsIm5iZiI6MTczNzgyNzQzMSwicGF0aCI6Ii8xNjg2MTkzMy80MDY2Nzg0ODgtOTJiMzc3NGMtMDIxNy00ZGI0LWExYzctMTIwZjc3NzhhMzkzLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTAxMjUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwMTI1VDE3NTAzMVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTZhMTkyMGYzZTI1MzQ5NzJjMGQ4NTE2ZDVhZTVjZmMwZWEzMzgwNmQ3NGQ1M2RiODAyMTRhZWZhNzQ3MTkxM2MmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.fFjExcog4tBrmndq2zs4iBEQy9yDX0GyM7Z-6vVPYlc)

1. Click the gear icon
2. Select 'Compiler Settings'
3. Provide path to Arduino 1.8.xx toolchain (e.g., `/mnt/hdd2/PortablePrograms/arduino-1.8.19/`)

### Compilation

![Compile Button](https://private-user-images.githubusercontent.com/16861933/406678498-1698e2f1-5f33-43d6-856f-bdee0694ea85.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzc4Mjc3MzEsIm5iZiI6MTczNzgyNzQzMSwicGF0aCI6Ii8xNjg2MTkzMy80MDY2Nzg0OTgtMTY5OGUyZjEtNWYzMy00M2Q2LTg1NmYtYmRlZTA2OTRlYTg1LnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTAxMjUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwMTI1VDE3NTAzMVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWI2NWFhNTliODBlNjEzYzhjZjg4NjZmZGRmMjM4ZWI5MjkwY2E1YTRkYzg4NGYyYzg2YTgzZDJmY2ZkNmVmZTAmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.LZyFfM-eUjwt-dxkB4ycMFkQYSm2W0vGmGdtZMwtcZs)

Click the 'Compile' button in the Top Panel.

## Additional Resources

- [SimulIDE Knowledge Base](https://simulide.com/p/simulidekb/)
- [GitHub Repository](https://github.com/eeTools)

## Desktop Entry Creation

Create a desktop entry for easy launching:

```bash
touch $HOME/.local/share/applications/SimulIDE.desktop
vim $HOME/.local/share/applications/SimulIDE.desktop
```

Sample desktop entry:

```
[Desktop Entry]
Type=Application
Name=SimulIDE
Comment=A simple real-time electronic circuit simulator
Icon=/home/YOURUSERNAME/.local/share/icons/simulide_385.png
Exec=/mnt/hdd2/PortablePrograms/SimulIDE_1.1.0-SR1_Lin64/simulide
Terminal=false
Categories=;
```

Download the [icon](https://raw.githubusercontent.com/Pinaki82/Debian-minimal/c1db1d164539d6438bbdaa3b114b7097177b490d/.local/share/icons/simulide_385.png) and place it in `$HOME/.local/share/icons`.

Note: Replace paths and username as appropriate.
