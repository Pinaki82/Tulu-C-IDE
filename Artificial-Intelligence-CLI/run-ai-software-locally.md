# Run AI Software Locally

Do you want to run AI models locally? You can. No specialised hardware is required, although you need a reasonably powerful "desktop" computer. Nevertheless, you can try it on low-end consumer machines. You can run some AI software suits on a low-power computer like mine; the only problem with this approach is that the software will sorely test your patience. You need a computer that has at least 16GB DDR3 RAM or better, a quad-core (four cores + four threads) CPU capable of running at 2.1GHz, 8.5GB storage space for models, and 200MB for the software. No fancy GPU is required. I tested it on my Windows desktop computer. Everything went okay.

My PC's specs:

```
Processor:      Intel(R) Core(TM) i5-4570S CPU @ 2.90GHz   2.90 GHz
                Haswell 22nm Technology
Installed RAM:  16.0 GB (15.5 GB usable) Dual-Channel
                DDR3 @ 781MHz
Board:          Gigabyte Technology Co. Ltd. H81M-S
Graphics:       ACER S271HL (1366x768@60Hz)
                Intel HD Graphics 4600 (Gigabyte)
                512MB NVIDIA GeForce 9600 GT (XFX Pine Group)
                ForceWare version: 342.01
                SLI Disabled
System type:    64-bit operating system, x64-based processor
Pen and touch:  No pen or touch input is available for this display
```

OS:

```
Edition:         Windows 10 Pro
Version:         20H2
Installed on:    ‎9/‎12/‎2020
OS build:        19042.1055
Experience:      Windows Feature Experience Pack 120.2212.2020.0
```

# [GPT4All](https://gpt4all.io/index.html)

Luckily, [GPT4All](https://gpt4all.io/index.html) offers you the "easy" solution.

Check whether your PC's CPU supports AVX2:

[GPT4All](https://gpt4all.io/index.html) is a GUI application. The models must be downloaded separately. No worry! You will find links to those models on their website. The models [GPT4All](https://gpt4all.io/index.html) supports are also supported by another program [LlamaGPTJ-chat](https://github.com/kuvaus/LlamaGPTJ-chat.git). The program [LlamaGPTJ-chat](https://github.com/kuvaus/LlamaGPTJ-chat.git) is a command-line program. It is a model runner that also checks whether your CPU supports AVX2. On top of that, you will need this small C++ program later if you wish to use the models via this program from your console. Many people love console applications, too. So, there's no loss.

Step 1:

Download [LlamaGPTJ-chat](https://github.com/kuvaus/LlamaGPTJ-chat.git)'s compiled executable files (depending on your OS) from the 'Release' section. For example: if you are on Windows, you'll need 1. chat-windows-latest-avx.exe and 2. chat-windows-latest-avx2.exe.

Open a terminal emulator of your choice, cmd.exe, WezTerm, Alacritty etc., in the directory where you've downloaded the executable files.

Type `chat-windows-latest-avx2.exe`.

```
C:\Users\USERNAME>chat-windows-latest-avx2.exe
LlamaGPTJ-chat (v. 0.2.1)
Your computer supports AVX2
LlamaGPTJ-chat: loading .\models\ggml-vicuna-13b-1.1-q4_2.bin
.
```

If you see `Your computer supports AVX2`, that means you are good to go with the regular versions of the model runner applications (both the [GPT4All](https://gpt4all.io/index.html) and [LlamaGPTJ-chat](https://github.com/kuvaus/LlamaGPTJ-chat.git)).

If not, Download the "AVX Only" version of [GPT4All](https://gpt4all.io/index.html) and keep the "chat-windows-latest-avx.exe" version of [LlamaGPTJ-chat](https://github.com/kuvaus/LlamaGPTJ-chat.git), since your CPU has no support for AVX2.

Step 2:

Download models:

The basic models:

1. [ggml-mpt-7b-chat.bin](https://gpt4all.io/models/ggml-mpt-7b-chat.bin)

2. [ggml-gpt4all-j-v1.3-groovy.bin](https://gpt4all.io/models/ggml-gpt4all-j-v1.3-groovy.bin)

There is no shortage of pre-trained models on their site for your use. These are the models [GPT4All](https://gpt4all.io/index.html) will first search for. Download the models with a download manager like [Free Download Manager](https://www.freedownloadmanager.org/). Usually, downloading such large files (4.52GB and 3.92GB, respectively) without the torrent protocol requires a download manager. [FDM](https://www.freedownloadmanager.org/) is a closed-source, proprietary, free-to-use file downloader application.

Step 3:

Install [GPT4All](https://gpt4all.io/index.html). It's fairly easy.

Copy chat-windows-latest-avx.exe or chat-windows-latest-avx2.exe (depending on the situation) into the `bin` directory of the installation folder of [GPT4All](https://gpt4all.io/index.html), generally, `%USERPROFILE%\gpt4all\bin`.

Step 4:

Add the `%USERPROFILE%\gpt4all\bin` folder to PATH:

`WINDOWS` + `r` -> type `systempropertiesadvanced` -> `ENTER`.

`Advanced` Tab -> `Environment Variables...` -> `System variables...` -> `Path` -> `New`. Paste the actual path there, `C:\Users\YOUR_USERNAME\gpt4all\bin`.

Step 5:

Create a hard symbolic link to a folder in another location of your hard drive where you will store the large models. I wanted to keep the downloaded model files (`*.bin`) in `N:\GPT4All`. The program expects the model files to be inside `C:\Users\YOUR_USERNAME\AppData\Local\nomic.ai\GPT4All\`. Sorry! I don't want those large files to occupy the system drive of my machine. I created a symbolic link. `mklink` is used to create symlinks in Windows.

```
mklink /Option Link Target
Or,
mklink /Option Virtual Actual

Options:
/D -> soft link
/H -> hard link
/J -> hard link pointing to a directory (directory junction)
```

Here, in my case, it was:

```
mklink /J "C:\Users\YOUR_USERNAME\AppData\Local\nomic.ai\GPT4All\" "N:\GPT4All"
```

Start `cmd.exe` in Administrator mode.

`WINDOWS` + `r` -> type `cmd` -> `CTRL + SHIFT + ENTER`.

Issue the appropriate command depending on where you want to store the downloaded models.

Now you can drop all model files in that folder on another partition. Do that now.

Step 6:

Create a `json` file for [LlamaGPTJ-chat](https://github.com/kuvaus/LlamaGPTJ-chat.git) to avoid typing lots of commands before using [LlamaGPTJ-chat](https://github.com/kuvaus/LlamaGPTJ-chat.git).

The file should be created in `C:\Users\YOUR_USERNAME\gpt4all\`.

```
type nul >> "%USERPROFILE%\gpt4all\chat.json"
```

```
notepad "%USERPROFILE%\gpt4all\chat.json"
```

Paste the contents given below.

```json
{
// CMD in Admin mode
// mklink /J "C:\Users\AppuRaja\AppData\Local\nomic.ai\GPT4All\" "N:\GPT4All"
// https://gpt4all.io/
// https://github.com/kuvaus/LlamaGPTJ-chat
// chat-windows-latest-avx2.exe -j %userprofile%\gpt4all\chat.json

//"model": "N:\GPT4All\ggml-gpt4all-j-v1.3-groovy.bin",
//"model": "N:\GPT4All\ggml-mpt-7b-chat.bin",
//"model": "N:\GPT4All\ggml-nous-gpt4-vicuna-13b.bin",
//"model": "N:\GPT4All\ggml-vicuna-7b-1.1-q4_2.bin",
//"model": "N:\GPT4All\ggml-wizardLM-7B.q4_2.bin",
//"model": "N:\GPT4All\ggml-nous-gpt4-vicuna-13b.bin",

"load_json": "N:\GPT4All\gpt4all\chat.json"
"load_log": "N:\GPT4All\chatlog.log",
"save_log": "N:\GPT4All\chatlog.log",
"n_predict": 100,
"top_p": 1.0,
"top_k": 50400,
"temp": 0.9,
"batch_size": 0.9,
"repeat_penalty": 1.1,
"n_batch": 20,
"threads": 4,
"model": "N:\GPT4All\ggml-mpt-7b-chat.bin",
"no-interactive": "false"
}
```

Step 7:

Run [GPT4All](https://gpt4all.io/index.html). Find it in your Start Menu.

To run [LlamaGPTJ-chat](https://github.com/kuvaus/LlamaGPTJ-chat.git) command-line model runner, issue this command:

```
chat-windows-latest-avx2.exe -j %USERPROFILE%\gpt4all\chat.json
```

Or, simply:

```
chat-windows-latest-avx2.exe -m "N:\GPT4All\ggml-mpt-7b-chat.bin" -t 4
```

A WinBATCH/BASH/FISH/ZSH script should work as well. The AI model `ggml-wizardLM-7B.q4_2.bin` generated almost perfect code, the last time I checked.

Feel free to experiment with the parameters. Change models and parameters in the `json` file. You need the `json` file to quickly insert flags into the [LlamaGPTJ-chat](https://github.com/kuvaus/LlamaGPTJ-chat.git) model runner. The `json` file is unrelated to the [GPT4All](https://gpt4all.io/index.html) GUI model runner program.

You might want to keep an eye on a similar program [koboldcpp](https://github.com/LostRuins/koboldcpp.git). It can run many AI model formats. The program is small, nearly 20MB.

For more details on [koboldcpp](https://github.com/LostRuins/koboldcpp.git):

https://github.com/LostRuins/koboldcpp

https://huggingface.co/TheBloke/WizardCoder-15B-1.0-GGML/blob/main/README.md

https://huggingface.co/TheBloke/WizardCoder-15B-1.0-GPTQ

https://huggingface.co/TheBloke/MPT-7B-Storywriter-GGML/discussions/2#6475d914e9b57ce0caa68888

Running [koboldcpp](https://github.com/LostRuins/koboldcpp.git):

```
koboldcpp.exe --help
```

```
koboldcpp.exe --model "N:\GPT4All\ggml-wizard-13b-uncensored.bin" --smartcontext --nommap
```

```
koboldcpp.exe --model "N:\GPT4All\WizardCoder-15B-1.0.ggmlv3.q4_1.bin" --smartcontext --nommap
```

Drop [koboldcpp](https://github.com/LostRuins/koboldcpp.git)'s compiled binary in the same folder where you have your [LlamaGPTJ-chat](https://github.com/kuvaus/LlamaGPTJ-chat.git) (`chat-windows-latest-avx2.exe`).

---

# Run small LLMs on low-end hardware under Linux (even without AVX/AVX2 support and GPUs)

Most of the instructions you'll see in this part are inspired by a GitHub [page](https://github.com/garyexplains/examples/blob/master/how-to-run-llama-cpp-on-raspberry-pi.md) demonstrated by [Gary Explains](https://github.com/garyexplains). This gentleman has tested the process of running LLMs for us on low-end hardware devices such as a [Raspberry Pi 4](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/) 8GB. It works on ARM CPUs, as well as x86 CPUs. Visit his [page](https://github.com/garyexplains/examples/blob/master/how-to-run-llama-cpp-on-raspberry-pi.md) to read the process in detail. Here's a quick overview of the steps:

[How to Run a ChatGPT-like AI Bot on a Raspberry Pi](https://github.com/garyexplains/examples/blob/master/how-to-run-llama-cpp-on-raspberry-pi.md)

Models will be downloaded from:

1. Hugging Face - TheBloke/Llama-2-7b-Chat-GGUF: https://huggingface.co/TheBloke/Llama-2-7b-Chat-GGUF/tree/main

2. Hugging Face - TheBloke/CodeLlama-7B-Instruct-GGUF: https://huggingface.co/TheBloke/CodeLlama-7B-Instruct-GGUF/tree/main

Thanks to [Hugging Face](https://huggingface.co/) for providing the LLMs.

The model runner application in this instance is [llama.cpp](https://github.com/ggerganov/llama.cpp.git). It has to be built before it can be used. Make sure you have Python 3 on the system and you can access Python from the terminal: `python3 --version`. On my Debian machine, the version of Python found is 3.11.2.

Set up your build environment:

Update the system and the installed packages.

```bash
sudo apt update
```

Install the C/C++ compiler toolchain.

```bash
sudo apt install bash git g++ wget build-essential sakura
```

Clone the source code of the model runner application.

```bash
git clone https://github.com/ggerganov/llama.cpp.git
```

Enter the source directory of the app.

```bash
cd llama.cpp
```

Build the app.

```bash
make -j
```

Or,

```bash
make -j2/j4/j8 (depending on the actual cores of the CPU on the machine)
```

Now, we will download the model files. Here's a simple analogy, model runners are like audio players whereas the model files (LLMs) are like MP3 files. We need files to run the program.

```bash
cd models
```

```bash
wget https://huggingface.co/TheBloke/Llama-2-7b-Chat-GGUF/resolve/main/llama-2-7b-chat.Q2_K.gguf
```

```bash
wget https://huggingface.co/TheBloke/CodeLlama-7B-Instruct-GGUF/resolve/main/codellama-7b-instruct.Q2_K.gguf
```

Switch to the source directory (move back to one directory level). The compiled program binary files are placed in the source directory for this program, "llama.cpp".

```bash
cd ../
```

Test the setup.

```bash
./main -m models/llama-2-7b-chat.Q2_K.gguf -p "in pure C programming language, write a function to create a Fibonacci sequence" -n 400 -e
```

```bash
./main -m models/codellama-7b-instruct.Q2_K.gguf -p "in pure C programming language, write a function to create a Fibonacci sequence" -n 400 -e
```

```bash
./main -m models/codellama-7b-instruct.Q2_K.gguf -p "in pure C programming language, write a program to create a Fibonacci sequence" -n 400 -e
```

Expect to get satisfactory answers from the AI Chatbot.

Interactive chat:

```bash
./main  -m models/llama-2-7b-chat.Q2_K.gguf --color \
       --ctx_size 2048 \
       -n -1 \
       -ins -b 256 \
       --top_k 10000 \
       --temp 0.2 \
       --repeat_penalty 1.1
```

```bash
./main  -m models/codellama-7b-instruct.Q2_K.gguf --color \
       --ctx_size 2048 \
       -n -1 \
       -ins -b 256 \
       --top_k 10000 \
       --temp 0.2 \
       --repeat_penalty 1.1
```

Create bash shell scripts and desktop entry files for easy access.

NOTE: Replace `YOUR_USERNAME` with your actual username, `echo $(whoami)`.

```bash
echo $(whoami)
```

Find the following files in the folder `Tulu-C-IDE/Artificial-Intelligence-CLI/llama.cpp`. Open the files with a text editor and make the necessary changes.

The launcher scripts (bash):

`interactive-codellama-instruct.sh`

```bash
#!/bin/bash

cd /home/YOUR_USERNAME/PortablePrograms/llama.cpp \

./main  -m models/codellama-7b-instruct.Q2_K.gguf --color \
       --ctx_size 2048 \
       -n -1 \
       -ins -b 256 \
       --top_k 10000 \
       --temp 0.2 \
       --repeat_penalty 1.1
```

`interactive-llama-chat.sh`

```bash
#!/bin/bash

cd /home/YOUR_USERNAME/PortablePrograms/llama.cpp \

./main  -m models/llama-2-7b-chat.Q2_K.gguf --color \
       --ctx_size 2048 \
       -n -1 \
       -ins -b 256 \
       --top_k 10000 \
       --temp 0.2 \
       --repeat_penalty 1.1
```

Desktop entries for easy access:

`llama-chat.desktop`

```bash
[Desktop Entry]
Type=Application
Name=llama-chat
Comment=AI Chat LLaMA
Icon=fbmessenger
Exec=sakura -e /home/YOUR_USERNAME/PortablePrograms/llama.cpp/interactive-llama-chat.sh
Terminal=false
Categories=;
```

`codellama.desktop`

```bash
[Desktop Entry]
Type=Application
Name=codellama
Comment=AI Chat LLaMA Code Instruct
Icon=fbmessenger
Exec=sakura -e /home/YOUR_USERNAME/PortablePrograms/llama.cpp/interactive-codellama-instruct.sh
Terminal=false
Categories=;
```

Copy the two desktop entry files that you've created to the `~/.local/share/applications` directory. Your launcher should show the entries. Type the following into the address bar of your file manager to enter the `~/.local/share/applications` directory.

```bash
~/.local/share/applications
```

## WizardCoder-Python

If you have a more powerful machine, like a Core i5 4th-gen, give WizardCoder-Python a try.

https://github.com/nlpxucan/WizardLM/blob/main/WizardCoder/README.md

https://www.reddit.com/r/WizardCoder/comments/164xemb/20230826_we_released_wizardcoderpython34bv10/

The 13B-Q2_K GGUF version can be downloaded from here:

https://huggingface.co/TheBloke/WizardCoder-Python-13B-V1.0-GGUF/tree/main

```bash
wget https://huggingface.co/TheBloke/WizardCoder-Python-13B-V1.0-GGUF/resolve/main/wizardcoder-python-13b-v1.0.Q2_K.gguf
```

A 34B-Q2_K version of WizardCoder-Python is available. Download that if you have a capable machine to run such a large model file.

https://huggingface.co/TheBloke/WizardCoder-Python-34B-V1.0-GGUF/tree/main

```bash
wget https://huggingface.co/TheBloke/WizardCoder-Python-34B-V1.0-GGUF/resolve/main/wizardcoder-python-34b-v1.0.Q2_K.gguf
```

The 13B version of CodeLlama:

```bash
wget https://huggingface.co/TheBloke/CodeLlama-13B-Instruct-GGUF/resolve/main/codellama-13b-instruct.Q2_K.gguf
```

### Additional AI Models Available for Download

In addition to the conversational AI models described previously, a variety of other AI models are available for download. These models are typically derived from the base models and are therefore not as performant as the conversational AI models. However, they offer a wider range of capabilities, and many of them have been fine-tuned by individuals and small teams, rather than large corporations.

These models are able to generate code, but it is important to be specific in your queries and to break them down into step-by-step instructions, each step of which should be provided in complete detail. For chat-style conversations, it is recommended to choose the chat/instruction versions of AI models.

[Marcoroni-7b-GGUF](https://huggingface.co/TheBloke/Marcoroni-7b-GGUF)

```bash
wget https://huggingface.co/TheBloke/Marcoroni-7b-GGUF/resolve/main/marcoroni-7b.Q2_K.gguf
```

[tulu-7B-GGUF](https://huggingface.co/TheBloke/tulu-7B-GGUF)

```bash
wget https://huggingface.co/TheBloke/tulu-7B-GGUF/resolve/main/tulu-7b.Q2_K.gguf
```

[Mistral-7B-v0.1-GGUF](https://huggingface.co/TheBloke/Mistral-7B-v0.1-GGUF)

```bash
wget https://huggingface.co/TheBloke/Mistral-7B-v0.1-GGUF/resolve/main/mistral-7b-v0.1.Q2_K.gguf
```

[gorilla-7B-GGUF](https://huggingface.co/TheBloke/gorilla-7B-GGUF)

```bash
wget https://huggingface.co/TheBloke/gorilla-7B-GGUF/resolve/main/Gorilla-7B.Q2_K.gguf
```

# LLaMA.CPP for Microsoft Windows

LLaMA.CPP runs on MS Windows. An appropriate version for Windows 10 can be downloaded from their GitHub release page: https://github.com/ggerganov/llama.cpp/releases

Download non-AVX versions if your CPU does not support AVX/AVX2. Download AVX2 for AVX2-supported CPUs. On my Windows machine, the archive `llama-bxxxx-bin-win-avx2-x64.zip` was the right option.

Make sure you download the `models` directory separately, `llama.cpp/models`. The folder `models` contains some configuration files required by `LLaMA.CPP`.

Multiline text input in LLaMA:

When you run LLaMA.CPP in interactive mode, you will not be able to hit Enter to break your input.

```
== Running in interactive mode. ==
 - Press Ctrl+C to interject at any time.
 - Press Return to return control to LLaMa.
 - To return control without starting a new line, end your input with '/'.
 - If you want to submit another line, end your input with '\'.
```

You'll have to add the string ` \` to continue to the subsequent lines. Doing that manually is a daunting task. Initially, I thought I would write two separate C programs using Win32 and GTK+ 3 to do that, with the plan of merging the programs into a single one employing a preprocessor directive. However, a simple web app can serve the purpose. I don't understand HTML/Javascript/CSS, to be honest. So, I asked `wizardcoder-python-13b-v1.0.Q2_K.gguf` to give me a solution. It worked, although the code had minor glitches that were later ironed out by ChatGPT.

If you need to insert multiple lines to LLaMA.CPP, open `formatted-copy.html` in your preferred browser. Type your prompts there. Format your prompts. Then, press a button to add ` \` at the end of each line, so you can copy the text in the exact format required by the runner, LLaMA.CPP.

---

**NOTE:**

1. Too **high CPU/RAM usage**. Jokes apart, be prepared to heat up your room with your computer.

2. Responses are generated very slowly, nearly one word per second in my setup. These two runner apps do not support GPUs. If they had support for at least the integrated graphics processor of the CPU (e.g., the iGPU in Intel CPUs), generating responses would have been way faster.

3. Requires a reasonably capable machine; at least 16GB DDR3 RAM and a 2GHz quad-core CPU. That requirement is the real minimum.

4. The models cannot be integrated into commercial chatbots, like AI chatbots in customer care services. Most of these models are derivative works of Meta's LLaMA model. Some of them are fine-tuned using OpenAI's responses.

5. For a trouble-free experience, use GPT4ALL in its default settings. It is the best overall model runner around.

Find a detailed review of AI models that you can run locally with GPT4ALL, `ai-model-test.txt`. The review is left as it is with no spelling/grammatical inconsistency correction.
