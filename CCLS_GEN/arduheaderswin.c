// Last Change: 2022-09-14  Wednesday: 10:21:56 PM
/*
  Compilation (Debug): gcc -g -Wall -Wextra -pedantic -fstack-protector-all arduheaderswin.c -o arduheaders
  Use (GDB):  gdb --args arduheaderswin.exe avr -mcpu=atmega328p %LOCALAPPDATA%\Arduino15 a n
  Use (GDB):  gdb --args arduheaderswin.exe avr -mcpu=atmega328p %LOCALAPPDATA%\Arduino15 a t
  Use (GDB):  gdb --args arduheaderswin.exe avr -mcpu=atmega328p %USERPROFILE%\.platformio p n
  Use (GDB):  gdb --args arduheaderswin.exe avr -mcpu=atmega328p %USERPROFILE%\.platformio p t
  Compilation: gcc -O2 -Wall -Wextra -pedantic -fstack-protector-all arduheaderswin.c -o arduheaderswin -s
  Use: arduheaderswin.exe avr -mcpu=atmega328p %LOCALAPPDATA%\Arduino15 a n
  Use: arduheaderswin.exe avr -mcpu=atmega328p %LOCALAPPDATA%\Arduino15 a t
  Use: arduheaderswin.exe avr -mcpu=atmega328p %USERPROFILE%\.platformio p n
  Use: arduheaderswin.exe avr -mcpu=atmega328p %USERPROFILE%\.platformio p t
  gdb --args arduheaderswin.exe avr -mcpu=atmega328p %LOCALAPPDATA%\Arduino15 a n

  ** rename the generated files.
   1) .ccls
   2) compile_flags.txt
   3) tagspath.txt

   NOTE: 'tagspath.txt' for PlatformIO SDK won't be generated.
   You can always run something like
   pio project init --ide vim --board uno --board nodemcuv2 --board teensy31
   which will generate a compile_flags.txt containing the 'include'
   directories of the PlatformIO SDK. Although you'll need a separate
   compile_flags.txt and a .ccls in your 'src' directory,
   the auto-generated compile_flags.txt will provide you with the
   directory list you need for accessing 'tags' database files.
   Plus, 'ctags' DB files can always be generated regardless of the
   SDK to aid the Vim plugin code_complete.vim.
*/

/*
  Arguments:
    the prog takes five arguments
  0) the name of the prog. itself (automatic. you won't be able to provide this argument)
  1) avr: the name of the MCU architecture
  2) -mcpu=atmega328p: the flag that tells the LSP to provide completion for
  a certain MCU model. Here, it is ATMEGA328p
  --------------------------------------------------------
  run any of the following commands, you'll get a basic idea
  --------------------------------------------------------
  llvm-config --host-target
  llc -march=armeb -mattr=help
  llc -march=arm -mattr=help
  llc --version | grep Default
  llc --version | grep armeb
  llc --version | grep Default
  llvm-config --host-target
  clang -v 2>&1 | grep Target
  clang-11 -print-targets
  clang -print-targets
  --------------------------------------------------------
  3) %LOCALAPPDATA%\Arduino15: the location of the SDK. This prog. will find header files
  in that location
  4) a or p: a means Arduino-CLI SDK. p means PlatformIO-Core-CLI SDK
  5) t: the flag t will generate 'tags' with ctags in the SDK's 'include' directories
  ) the last argument is a newline char reciprocated as a NULL terminator
*/

/*
  Installation:

  MSYS2 :
  Windows+R
  systempropertiesadvanced
  Environment Variables -> System Variables -> Path -> Edit -> New
  C:\msys64\usr\bin
  C:\msys64\usr\x86_64-pc-msys\bin
  C:\msys64
  C:\msys64\mingw64\bin
  C:\msys64\opt\node-vXX.YY.Z-win-x64
  C:\msys64\home\YOUR_USERNAME\bin

  arduheaderswin :
  Windows+R -> cmd -> CTRL+SHIFT+ENTER (Privilege escalation)
  cd C:\
  cd %PROGRAMFILES%
  mkdir arduheaderswin
  Copy arduheaderswin.exe into %PROGRAMFILES%\arduheaderswin

  Windows+R
  systempropertiesadvanced
  Environment Variables -> System Variables -> Path -> Edit -> New
  C:\Program Files\arduheaderswin

  BASH Shell:
  Open $HOME/.bashrc (C:\msys64\home\YOUR_USERNAME) with a text editor and
  paste the following line in the beginning:
  export PATH=/home/YOUR_USERNAME/bin/:$PATH
  Fish Shell:
  Open $HOME/.config/fish/config.fish
  (C:\msys64\home\YOUR_USERNAME\.config\fish) with a text editor and
  paste the following lines in the beginning:
  # --------------
  export PATH="/home/YOUR_USERNAME/bin/:$PATH"
  export PATH
  # --------------
  Restart the MSYS2 Shell.

  Use: Enter a directory, then type 'arduheaderswin' (without quotes),
  e.g., arduheaderswin.exe avr -mcpu=atmega328p %USERPROFILE%\.platformio p n
  then run the prog.
*/

// Restrict to MS-Windows systems only
#if !( defined( _WIN64 ) || defined(__MINGW64__) )
  #error "For MSYS2x64 on 64-bit MS-Windows Only"
#endif

#define MAX_LENGTH_OF_INOUTSTR 1000000
/*
  For changing the current working dir
  https://docs.microsoft.com/en-us/windows/win32/fileio/changing-the-current-directory
  https://stackoverflow.com/questions/27585930/get-the-current-working-directory-in-c-on-windows
*/
#define BUFSIZE MAX_PATH

#include <windows.h>
#include <tchar.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <stdint.h>
#include <unistd.h>
#include "duprem.h"

extern unsigned int linesCount;

void sort_rough(void);
void ccls(char *target, char *mcu, char *ardu_or_pio);
void compile_flags_DOT_txt(char *target, char *mcu, char *ardu_or_pio);
void gen_tags(void);
void dirswitch_n_ctags(char *command);
void vim_tagspath(void);
int gcc_version(void);
void tmp_file_cleanup(void);

int main(int argc, char **argv) {
  FILE *fp, *fp2;
  char cont[1000]; // variable to read the 'content'
  size_t len = 0;
  unsigned int line_no = 0;
  char dot_h_lookupString[] = ".h";
  unsigned int i = 0;
  unsigned int last_slash_counter = 1;
  /*  */
  char full_str_2_pass[MAX_LENGTH_OF_INOUTSTR];
  //char *target;
  //char *mcu;
  char *path_2_ardu_or_pio;
  char yesno;
  /* cleanup cache files generated in the previous run */
  tmp_file_cleanup();
  system("del arduheader.txt");
  system("del ardupath.txt");
  /* cache cleanup */
  printf("Prog. name: %s\n", *argv);
  printf("Usage: arduheaderswin.exe target mcu Path_to_th_platform a t\n");
  printf("Supply as arguments\n1. the target\n2. the exact mcu\n3. the full path to\n   ArduinoXX or .platformio\nfound in your %%LOCALAPPDATA%% or %%USERPROFILE%% folder\n4. a (Arduino) or p (PlatformIO)\nand\n5. t (for generating tags)\nbefore running this program.\n");
  printf("Example 1: arduheaderswin.exe avr -mcpu=atmega328p %%LOCALAPPDATA%%\\Arduino15 a t\n");
  printf("Or\n");
  printf("Example 2: arduheaderswin.exe avr -mcpu=atmega328p %%USERPROFILE%%\\.platformio p t\n");
  printf("Example 3 (to not generate tags): arduheaderswin.exe avr -mcpu=atmega328p %%USERPROFILE%%\\.platformio p n\n");
  printf("Here:\n");
  printf("1. target architecture = avr \n");
  printf("2. mcu = -mcpu=atmega328p (write the accurate info)\n");
  printf("3. full path = %%LOCALAPPDATA%%\\Arduino15 (could be Arduino16 in the future)\n");
  printf("4. a) t -- > Generate tags b) any other char -- > do not generate tags\n");
  printf("For more information, consult the documentation or read the source file.\n");
  printf("no. of argc %d. no. of user supplied argc %d.\n", argc, (argc - 1));

  if(argc == 6) { // the last argument is a null char generated from the user input. The first one is the prog. name
    printf("The arguments supplied are:\n1. %s\n2. %s\n3. %s\n4. %s\n5. %s\n", *(argv + 1), *(argv + 2), *(argv + 3), *(argv + 4), *(argv + 5));
    path_2_ardu_or_pio = *(argv + 3);
    printf("SDK folder: %s\n", path_2_ardu_or_pio);
  }

  else if(argc > 6) {
    printf("Too many arguments supplied.\n");
    exit(EXIT_FAILURE);
  }

  else {
    printf("Expected arguments were 5 (five).\n");
    exit(EXIT_FAILURE);
  }

  char *a_or_p = *(argv + 4);

  if((*a_or_p == 'a') && (strstr(*(argv + 3), "Arduino") == NULL)) {
    printf("The directory you typed does not appear to be an Arduino SDK directory\n");
    printf("Do you still want to proceed? ... (y/n)\n");
    scanf("%c", &yesno);

    if(!((yesno == 'y') || (yesno == 'Y'))) {
      printf("Please start over\n");
      exit(EXIT_FAILURE);
    }
  }

  else if((*a_or_p == 'p') && (strstr(*(argv + 3), "platformio") == NULL)) {
    printf("The directory you typed does not appear to be a PlatformIO SDK directory\n");
    printf("Do you still want to proceed? ... (y/n)\n");
    scanf("%c", &yesno);

    if(!((yesno == 'y') || (yesno == 'Y'))) {
      printf("Please start over\n");
      exit(EXIT_FAILURE);
    }
  }

  printf("Are you sure that all your inputs are\n1. in proper order\nand\n2. accurate? (y/n)\n");
  scanf("%c", &yesno);

  if(!((yesno == 'y') || (yesno == 'Y'))) {
    printf("Please start over\n");
    exit(EXIT_FAILURE);
  }

  char find001[] = "dir /s/b \""; // %LOCALAPPDATA%\Arduino15
  char find002[] = "\\*.h\" > ardupath.txt";
  strcat(full_str_2_pass, find001);
  strcat(full_str_2_pass, path_2_ardu_or_pio);
  strcat(full_str_2_pass, find002);
  printf("full_str_2_pass %s\n", full_str_2_pass);
  system("PAUSE");
  system(full_str_2_pass); // this will generate ardupath.txt
  fp = fopen("ardupath.txt", "r"); // opening of file

  if(fp == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  while(fgets(cont, 1000, fp) != NULL) {
    ++line_no;
    len = strlen(cont) - 1;

    if(strstr(cont, dot_h_lookupString) != 0) {
      char *p = (char *)malloc((size_t)(strlen(cont) + 1) * sizeof(char));

      if(p == NULL) {
        printf("Memory allocation failed. Goodbye.\n");
        exit(EXIT_FAILURE);
      }

      char *reducedStr = (char *)malloc((size_t)(strlen(cont) + 1) * sizeof(char));

      if(reducedStr == NULL) {
        printf("Memory allocation failed. Goodbye.\n");
        exit(EXIT_FAILURE);
      }

      char *reducedStrMore = (char *)malloc((size_t)(strlen(cont) + 1) * sizeof(char));

      if(reducedStrMore == NULL) {
        printf("Memory allocation failed. Goodbye.\n");
        exit(EXIT_FAILURE);
      }

      strcpy(p, cont);
      /*printf("\n%u Here p = %s\n", line_no, p);*/

      for(i = 0; i < len; i++) {
        reducedStr[i] = '\0';
      }

      for(i = 0; i < len; i++) {
        reducedStrMore[i] = '\0';
      }

      for(i = 0 ; (i < len - 2)  ; i++) {
        reducedStr[i] = *(p + i);
      }

      for(i = len - 2 ; (i > 0)  ; i--) {
        if(reducedStr[i] == 92) { // ASCII backslash is 92
          last_slash_counter = i;
          break;
        }
      }

      for(i = 0; (i < last_slash_counter)  ; i++) {
        reducedStrMore[i] = *(reducedStr + i);
      }

      /*printf("\n%u Here reducedStr = %s\nreducedStrMore = %s\n", line_no, reducedStr, reducedStrMore);*/
      fp2 = fopen("arduheader.txt", "a"); // open & append to file

      if(fp2 == NULL) {  // checking for errors
        printf("couldn't open the \n");
        exit(EXIT_FAILURE);
      }

      fprintf(fp2, "%s\n", reducedStrMore);
      //printf("%s\n", reducedStr);
      //printf("%s\n", reducedStrMore);
      fclose(fp2);
      free(p);
      p = NULL;
      free(reducedStr);
      reducedStr = NULL;
      free(reducedStrMore);
      reducedStrMore = NULL;
    }
  }

  sort_rough();
  fclose(fp); // closing file
  ccls(*(argv + 1), *(argv + 2), *(argv + 4));
  compile_flags_DOT_txt(*(argv + 1), *(argv + 2), *(argv + 4));

  if(*argv[5] == 't') {
    printf("Generating tags db...\n");
    gen_tags();
    printf("Complete.\n");
  }

  if(*argv[4] != 'p') {
    printf("Generating tags db...\n");
    vim_tagspath();
    printf("Complete.\n");
  }

  tmp_file_cleanup();
  system("del arduheader.txt");
  system("del ardupath.txt");
  return 0;
}

void sort_rough(void) {
  system("del sorted.txt"); /* For dup line remover */
  char for_finar_srt_file2opn[] = "sorted.txt";
  char for_finar_srt_outfile[] = "final_sorting.txt";
  static const char filename[] = "arduheader.txt";
  FILE *file = fopen(filename, "r");
  FILE *fp2, *fp3;
  unsigned int count = 0;
  char ch;
  int compared = 0;
  unsigned int linesCount = 0;
  char hold[1000];
  char line[1000]; /* or other suitable maximum line size */
  // linesCount
  fp2 = fopen("arduheader.txt", "r"); // open file in read-only mode

  if(fp2 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  while((ch = fgetc(fp2)) != EOF) {
    if(ch == '\n') {
      linesCount++;
    }
  }

  fclose(fp2); // closing file
  /*printf("linesCount %u\n", linesCount);*/
  // linesCount ends here
  fp3 = fopen("sorted.txt", "a"); // open & append to file

  if(fp3 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  while(count < 1000) {
    hold[count] = '\0';
    count++;
  }

  while(fgets(line, sizeof line, file) != NULL) { /* read a line */
    compared = strcmp(hold, line);

    if(compared != 0) {
      strcpy(hold, line);
      fprintf(fp3, "%s", line);
    }

    count++;

    if(count == linesCount) {
      continue;
    }
  }

  fclose(file);
  fclose(fp3); // closing file
  duplinerm(for_finar_srt_file2opn, for_finar_srt_outfile);
}

void ccls(char *target, char *mcu, char *ardu_or_pio) {
  system("del ccls.txt");
  int i = 0;
  static const char filename01[] = "final_sorting.txt";
  static const char filename02[] = "ccls.txt";
  FILE *file01 = fopen(filename01, "r");
  FILE *file02 = fopen(filename02, "a");
  FILE *fp4;
  char line[1000]; /* or other suitable maximum line size */
  char type_o_platform;
  type_o_platform = *ardu_or_pio;
  /*printf("ccls() received ardu_or_pio = %c\n", type_o_platform);*/
  char prepend_2_final_arduino[43][1000] = {
    "clang",
    "%c -std=c11",
    "%cpp -std=c++17",
    "%cpp -stdlib=libc++",
    "%cpp -stdlib=libstdc++",
    "%h %hpp --include=Global.h",
    "-Iinc",
    "-DMACRO",
    "",
    "",
    "%c -Wall",
    "%c -Weffc++",
    "%c -Wextra",
    "%c -pedantic",
    "%c -Wfatal-errors",
    "%c -Winit-self",
    "%c -Wnon-virtual-dtor",
    "%c -Winline",
    "%c -Wmissing-declarations",
    "%c -Wmissing-include-dirs",
    "%c -Wundef",
    "%c -Wredundant-decls",
    "%c -Wfloat-equal",
    "%c -Wmain",
    "%c -Wunreachable-code",
    "%c -Wshadow",
    "%c -Wcast-align",
    "%c -Wswitch-default",
    "%c -Wswitch-enum",
    "%c -Wstrict-prototypes",
    "%c -Wmissing-prototypes",
    "%c -Wmissing-declarations",
    "%c -Wnested-externs",
    "%c -Wformat=2",
    "%c -Wformat-security",
    "%c -Wformat-signedness",
    "%c -Wformat-y2k",
    "%c -Wconversion",
    //"%c -Weverything",
    "%c -ferror-limit=0",
    "%c -ftemplate-backtrace-limit=0",
    /*"%c -target",*/
    /*"%c x86_64-pc-linux-gnu",*/
  };
  char minus_target[2][1000] = {
    "%c -target",
    "%c --target=",
  };
  char prepend_2_final_arduino_last_newlines[2][1] = {
    "",
    "",
  };

  if(file01 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  if(file02 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  fp4 = fopen("ccls.txt", "a"); // open & append to file

  if(fp4 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  for(i = 0; i < 43 ; i += 1) {
    fprintf(fp4, "%s\n", *(prepend_2_final_arduino + i));
  }

  if(type_o_platform == 'a') {
    fprintf(fp4, "%s\n", *(minus_target + 0));
    fprintf(fp4,
            "%%c "); // https://www.geeksforgeeks.org/how-to-print-using-printf/
    fprintf(fp4, "%s\n", target);
  }

  else if(type_o_platform == 'p') {
    fprintf(fp4, "%s", *(minus_target + 1));
    fprintf(fp4, "%s\n", target);
  }

  else {
    printf("Probably, your input was incorrect.\n");
  }

  fprintf(fp4, "%%c ");
  fprintf(fp4, "%s\n", mcu);

  for(i = 0; i < 2 ; i += 1) {
    fprintf(fp4, "%s\n", *(prepend_2_final_arduino_last_newlines + i));
  }

  while(fgets(line, sizeof line, file01) != NULL) { /* read a line */
    fprintf(fp4, "-I%s", line);
  }

  fclose(file01);
  fclose(file02);
  fclose(fp4);
}

void compile_flags_DOT_txt(char *target, char *mcu, char *ardu_or_pio) {
  system("del 0compile_flags.txt");
  int i = 0;
  static const char filename01[] = "final_sorting.txt";
  static const char filename02[] = "0compile_flags.txt";
  FILE *file01 = fopen(filename01, "r");
  FILE *file02 = fopen(filename02, "a");
  FILE *fp4;
  char line[1000]; /* or other suitable maximum line size */
  char type_o_platform;
  type_o_platform = *ardu_or_pio;
  /*printf("compile_flags() received ardu_or_pio = %c\n", type_o_platform);*/
  char prepend_2_final_arduino[33][1000] = {
    "-Wall",
    "-Weffc++",
    "-Wextra",
    "-pedantic",
    "-Wfatal-errors",
    "-Winit-self",
    "-Wnon-virtual-dtor",
    "-Winline",
    "-Wmissing-declarations",
    "-Wmissing-include-dirs",
    "-Wundef",
    "-Wredundant-decls",
    "-Wfloat-equal",
    "-Wmain",
    "-Wunreachable-code",
    "-Wshadow",
    "-Wcast-align",
    "-Wswitch-default",
    "-Wswitch-enum",
    "-Wstrict-prototypes",
    "-Wmissing-prototypes",
    "-Wmissing-declarations",
    "-Wnested-externs",
    "-Wformat=2",
    "-Wformat-security",
    "-Wformat-signedness",
    "-Wformat-y2k",
    "-Wconversion",
    //"-Weverything",
    "-ferror-limit=0",
    "-ftemplate-backtrace-limit=0",
    /*"-target",*/
    /*"x86_64-pc-linux-gnu",*/
  };
  char minus_target[2][1000] = {
    "-target",
    "--target=",
  };
  char prepend_2_final_arduino_last_newlines[2][1] = {
    "",
    "",
  };

  if(file01 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  if(file02 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  fp4 = fopen("0compile_flags.txt", "a"); // open & append to file

  if(fp4 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  for(i = 0; i < 33 ; i += 1) {
    fprintf(fp4, "%s\n", *(prepend_2_final_arduino + i));
  }

  if(type_o_platform == 'a') {
    fprintf(fp4, "%s\n", *(minus_target + 0));
    fprintf(fp4, "%s\n", target);
  }

  else if(type_o_platform == 'p') {
    fprintf(fp4, "%s", *(minus_target + 1));
    fprintf(fp4, "%s\n", target);
  }

  else {
    printf("Probably, your input was incorrect.\n");
  }

  fprintf(fp4, "%s\n", mcu);

  for(i = 0; i < 2 ; i += 1) {
    fprintf(fp4, "%s\n", *(prepend_2_final_arduino_last_newlines + i));
  }

  while(fgets(line, sizeof line, file01) != NULL) { /* read a line */
    fprintf(fp4, "-I%s", line);
  }

  fclose(file01);
  fclose(file02);
  fclose(fp4);
}

void gen_tags(void) {
  /*
    https://docs.microsoft.com/en-us/windows/win32/fileio/changing-the-current-directory
    https://stackoverflow.com/questions/27585930/get-the-current-working-directory-in-c-on-windows
  */
  int i = 0;
  char line[5000]; /* or other suitable maximum line size */
  char line_minus_one_char[5000]; /* or other suitable maximum line size */
  char _dkey[] = " doskey cd=chdir/d $* ";
  char _cd[] = "cd ";
  char _quote[] = "\"";
  char _dblamp[] = " && ";
  char newline[] = "\n";
  char totalcommand[15000];
  //char ctagscmd[400] = "ctags -R --sort=yes --c-kinds=+pxfvtdeglmsu --c++-kinds=+pxfvtcdeglmnsu --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+iaSmz --extras=+qf -f tags * ";
  /*
    https://www.tutorialspoint.com/unix_commands/ctags.htm
    ctags --list-kinds
    ctags --list-fields
    ctags --list-extras
  */
  char ctagscmd[400] = "ctags -R --sort=yes --c-kinds=+pfd --c++-kinds=+pfd --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+lSmz --extra=+f -f tags * ";
  static const char filename01[] = "final_sorting.txt";
  FILE *file01 = fopen(filename01, "r");

  if(file01 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  i = 0;

  do {
    totalcommand[i] = '\0';
    line[i] = '\0';
    i++;
  } while(i < 15000);

  i = 0;

  do {
    line[i] = '\0';
    line_minus_one_char[i] = '\0';
    i++;
  } while(i < 5000);

  while(fgets(line, sizeof line, file01) != NULL) { /* read a line */
    //printf("%s\n", line);
    i = 0;

    do {
      totalcommand[i] = '\0';
      i++;
    } while(i < 15000);

    i = 0;

    do {
      line_minus_one_char[i] = '\0';
      i++;
    } while(i < 5000);

    i = 0;
    strcat(totalcommand, _dkey);
    strcat(totalcommand, _dblamp);
    strcat(totalcommand, _cd);
    strncpy(line_minus_one_char, line, strlen(line) - 1);
    strcat(totalcommand, _quote);
    strcat(totalcommand, line_minus_one_char);
    strcat(totalcommand, _quote);
    strcat(totalcommand, _dblamp);
    strcat(totalcommand, ctagscmd);
    strcat(totalcommand, newline);
    //printf("totalcommand is: %s\n", for_chngng_dir);
    dirswitch_n_ctags(totalcommand);
    i = 0;

    do {
      line[i] = '\0';
      i++;
    } while(i < 5000);

    i = 0;
  }

  fclose(file01);
}

void dirswitch_n_ctags(char *command) {
  TCHAR Buffer[BUFSIZE];
  DWORD dwRet;
  dwRet = GetCurrentDirectory(BUFSIZE, Buffer);

  if(dwRet == 0) {
    printf("GetCurrentDirectory failed (%ld)\n", GetLastError());
    return;
  }

  if(dwRet > BUFSIZE) {
    printf("Buffer too small; need %ld characters\n", dwRet);
    return;
  }

  if(!SetCurrentDirectory("C:")) {
    printf("SetCurrentDirectory failed (%ld)\n", GetLastError());
    return;
  }

  /* http://superuser.com/questions/225692/why-is-cd-in-windows-not-able-to-switch-between-drives */
  system(" doskey cd=chdir/d $* ");
  printf("command to pass: %s\n", command);
  system(command);

  if(!SetCurrentDirectory(Buffer)) {
    printf("SetCurrentDirectory failed (%ld)\n", GetLastError());
    return;
  }

  //system("echo %cd%");
}

void vim_tagspath(void) {
  system("del arduvim-tagspath.txt");
  int i = 0, j = 0;
  char line[5000]; /* or other suitable maximum line size */
  static const char filename01[] = "final_sorting.txt";
  FILE *file01 = fopen(filename01, "r");

  if(file01 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  static const char filename03[] = "arduvim-tagspath.txt";
  FILE *file02 = fopen(filename03, "a");

  if(file02 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  while(fgets(line, sizeof line, file01) != NULL) { /* read a line */
    if(i == 0) {
      i++;
      continue;
    }

    char *intrchng = line;
    intrchng[strlen(intrchng) - 1] = 0; // https://stackoverflow.com/questions/9628637/how-can-i-get-rid-of-n-from-string-in-c // foo[strlen(foo) - 1] = 0;
    fprintf(file02, "\n%s%s%s", "set tags+=", intrchng, "/tags;/");
    fprintf(file02, "\n%s%s%s", "set path+=", intrchng, "/;/");
    i++;
    j = 0;

    do {
      line[j] = '\0';
      j++;
    } while(j < 5000);
  }

  fprintf(file02, "\nset tags+=./tags;/");
  fprintf(file02, "\nset path+=./;/");
  fclose(file02);
  fclose(file01);
}

int gcc_version(void) {
  system("del gccdumpver.txt");
  FILE *fp;
  char gcc_dump_command[] = "gcc -dumpversion > gccdumpver.txt";
  char line[100];
  int version = 0;
  int i = 0;
  // char *version_as_str;
  system(gcc_dump_command);
  fp = fopen("gccdumpver.txt", "r");
  i = 0;

  while((i < 1) && (fgets(line, sizeof line, fp) != NULL)) {
    sscanf(line, "%d",
           &version); /* https://www.tutorialspoint.com/converting-strings-to-numbers-in-c-cplusplus */
    printf("%d\n", version); // version number is now stored into 'version'
    i++;
  }

  fclose(fp);
  return version;
}

void tmp_file_cleanup(void) {
  system("del arduheader.txt");
  system("del ardupath.txt");
  system("del sorted.txt");
  system("del final_sorting.txt");
}

