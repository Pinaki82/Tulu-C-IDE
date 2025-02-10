# Premake5: How to Build Premake

## References

> https://share.beago.ai/searchLanding?id=92321323867128592&plf=web&src=copy
> 
> https://github.com/premake/premake-core/blob/master/BUILD.txt
> 
> https://premake.github.io/docs/Building-Premake/

## Clone the Repository

1. Open your terminal or command prompt.  

2. Use the following command to clone the repository:

```bash
git clone https://github.com/premake/premake-core.git
cd premake-core
```

3. To build the repository from the source (on Linux), type:

```bash
./Bootstrap.sh
```

Or (on MS Windows with Mingw-w64/MSYS2),

```
CC=mingw32-gcc mingw32-make -f Bootstrap.mak mingw
```

## Run the executable

To run the executable on Linux, simply type:

```bash
cd bin/release/
./premake5 --help
```

# Install Premake5 on your Linux system

```bash
install -m +x example.so luasocket.so premake5 $HOME/.local/bin
```

It might be necessary for Microsoft Windows users to change the release directory's name to something more comprehensible, such as Premake5, copy it to the `%PROGRAMFILES%` directory, and then add that directory to the system path.

# Test Premake5 after install

```bash
premake5 --help
```

## Usage

https://premake.github.io/docs/Your-First-Script
