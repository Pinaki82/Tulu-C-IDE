'systags' generates a .ccls file and a compile_flags.txt in the current working directory (CWD/PWD). (More on this later).

'arduheaders' can generate the following three files for Arduino-CLI SDK and PlatformIO-Core-CLI SDK:

- .ccls
- compile_flags.txt
- tagspath.txt

The program can also generate 'tags' (ctags is a dependency) in the 'include' directories of the SDKs mentioned.

Read the source for more info.
