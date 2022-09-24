// Last Change: 2022-09-24  Saturday: 11:32:45 PM

/*
  Compilation (Debug): gcc -g -Wall -Wextra -pedantic -fstack-protector-all systagswin.c -o systagswin
  Use (GDB):  gdb --args systagswin.exe %systemdrive%\msys64
  Compilation: gcc -O2 -Wall -Wextra -pedantic -fstack-protector-all systagswin.c -o systagswin -s
  Use: systagswin.exe %systemdrive%\msys64
  Then rename the generated files:
  .ccls
  compile_flags.txt
  tagspath.txt
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

  systagswin :
  Windows+R -> cmd -> CTRL+SHIFT+ENTER (Privilege escalation)
  cd C:\
  cd %PROGRAMFILES%
  mkdir systagswin
  explorer %PROGRAMFILES%\systagswin
  Copy systagswin.exe into %PROGRAMFILES%\systagswin

  Windows+R
  systempropertiesadvanced
  Environment Variables -> System Variables -> Path -> Edit -> New
  C:\Program Files\systagswin

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

  Use: Enter a directory, then type 'systagswin' (without quotes),
  then run the prog.,
  e.g., systagswin %systemdrive%\msys64
  Or,
  systagswin.exe %systemdrive%\msys64
  MSYS2 dir: C:\msys64
  %SYSTEMDRIVE% expands to C:
*/


// Restrict to MS-Windows systems only
#if !( defined( _WIN64 ) || defined(__MINGW64__) )
  #error "For MSYS2x64 on 64-bit MS-Windows Only"
#endif

#define BUFSIZE MAX_PATH

#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <stdint.h>
#include <unistd.h>

int discbrake = 0;

char *gcc_version(void);
void compile_flags(char *msys2path);
void ccls(int *consent, char *msys2path);
void gen_tags(char *msys2path);
void dirswitch_n_ctags(char *command);
char *replaceWord(const char *s, const char *oldW, const char *newW);

int main(int argc, char **argv) {
  int yesno = 0;
  char *version;
  printf("Program name: %s\n", argv[0]);
  printf("argument received: %s\n", argv[1]);
  printf("Use: systagswin.exe \"PATH\\TO\\MSYS2\"\n");
  printf("Example: systagswin.exe \"%%systemdrive%%\\msys64\"\n");

  if(argc != 2) {
    printf("Expected one user supplied argument only.\n");
    exit(EXIT_FAILURE);
  }

  if(strstr(*(argv + 1), "msys64") == NULL) {
    printf("The directory you typed does not appear to be an MSYS2-x64 installation directory.\n");
    printf("Please start over...\n");
    exit(EXIT_FAILURE);
  }

  printf("To generate tags db in system's include directories you'll need admin privilege.\n");
  printf("Windows+R -> cmd -> CTRL+SHIFT+ENTER \n");
  printf("0 (zero) means NO. 1 (one) means YES.\n");
  printf("Do you want to generate tags db with ctags as well? (1/0)\n");
  scanf("%d", &yesno);
  version = gcc_version();
  printf("GCC version: %s\n", version);
  compile_flags(argv[1]);
  ccls(&yesno, argv[1]);
  return 0;
}

char *gcc_version(void) {
  FILE *fp;
  char gcc_dump_command[] = "gcc -dumpversion > gccdumpver.txt";
  char line[100];
  char *version = NULL;
  int i = 0;
  system(gcc_dump_command);
  fp = fopen("gccdumpver.txt", "r");
  i = 0;

  while((i < 1) && (fgets(line, sizeof line, fp) != NULL)) {
    fscanf(fp, "%s", line);
    unsigned long long leng_of_line = strlen(line) - 1;
    version = (char *)malloc((size_t)leng_of_line * sizeof(char));

    if(version == NULL) {
      fprintf(stderr, "\ndynamic memory allocation failed\n");
      exit(EXIT_FAILURE);
    }

    strcpy(version, line);
    // printf("%s\n", version); // version number is now stored into 'version'
    i++;
  }

  fclose(fp);
  system("del gccdumpver.txt");
  return(version);
}

void compile_flags(char *msys2path) {
  static const char filename01[] = "msys2-compile_flags.txt";
  system("del msys2-compile_flags.txt");
  FILE *file01 = fopen(filename01, "w");

  if(file01 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  char cmpl_flags_skeleton01[34][100] = {
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
    "-Weverything",
    "-ferror-limit=0",
    "-ftemplate-backtrace-limit=0",
    "-target",
    "x86_64-pc-windows-gnu",
    "",
  };
  char cmpl_flags_skeleton02[2][100] = {
    "-isystem YYYY\\mingw64\\include",
    "-isystem YYYY\\mingw64\\include\\c++\\XXXX",
  };

  for(int i = 0; i < 34 ; i += 1) {
    fprintf(file01, "%s\n", *(cmpl_flags_skeleton01 + i));
  }

  fclose(file01);
  file01 = fopen(filename01, "a");

  if(file01 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  char xxxx[5] = "XXXX";
  char yyyy[5] = "YYYY";
  char dbl_b_slash[4] = "\\\\"; // https://prepinsta.com/all-about-c-language/how-to-print-backslash-using-printf/
  char b_slash[2] = "\\";
  char *num;
  num = gcc_version();
  // char num_str[5]; // result will be converted to a string and stored into 'num_str'
  // sprintf(num_str, "%f", num); // https://www.geeksforgeeks.org/what-is-the-best-way-in-c-to-convert-a-number-to-a-string/
  // printf("in system_tags here: %s\n", num_str);
  // printf("path rcvd. %s\n", msys2path);
  char *result = NULL;
  char *result2 = NULL;
  char *result3 = NULL;

  for(int i = 0; i < 2 ; i += 1) {
    result = replaceWord((*(cmpl_flags_skeleton02 + i) + 0), xxxx, num);
    result2 = replaceWord(result, yyyy, msys2path);
    result3 = replaceWord(result2, dbl_b_slash, b_slash);
    // printf("New String: %s\n", result);
    fprintf(file01, "%s\n", result3);
  }

  fclose(file01);
}

void ccls(int *consent, char *msys2path) {
  system("del msys2.ccls.txt");
  system("del msys2.tagspath.txt");
  static const char filename01[] = "msys2.ccls.txt";
  FILE *file01 = fopen(filename01, "w");

  if(file01 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  static const char filename02[] = "msys2.tagspath.txt";
  FILE *file02 = fopen(filename02, "w");

  if(file02 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  char prepend_2_final[45][1000] = {
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
    "%c -Weverything",
    "%c -ferror-limit=0",
    "%c -ftemplate-backtrace-limit=0",
    "%c -target",
    "%c x86_64-pc-windows-gnu",
    "",
    "",
  };
  char flags_skeleton[2][100] = {
    "-IYYYY\\mingw64\\include",
    "-IYYYY\\mingw64\\include\\c++\\XXXX",
  };
  char vim_tags[4][100] = {
    "set tags+=YYYY\\mingw64\\include\\tags;\\",
    "set tags+=YYYY\\mingw64\\include\\c++\\XXXX\\tags;\\",
    "set tags+=./tags;/",
    "",
  };
  char vim_tags_searchpath[3][100] = {
    "set path+=YYYY\\mingw64\\include\\;\\",
    "set path+=YYYY\\mingw64\\include\\c++\\XXXX\\;\\",
    "set path+=./;/",
  };

  for(int i = 0; i < 45 ; i += 1) {
    fprintf(file01, "%s\n", *(prepend_2_final + i));
  }

  fclose(file01);
  file01 = fopen(filename01, "a");

  if(file01 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  char xxxx[5] = "XXXX";
  char yyyy[5] = "YYYY";
  char dbl_b_slash[4] = "\\\\"; // https://prepinsta.com/all-about-c-language/how-to-print-backslash-using-printf/
  char b_slash[2] = "\\";
  char *num;
  char *num2; // to get rid of the newline char
  num = gcc_version();
  unsigned long long len;
  len = strlen(num) - 1;
  num2 = (char *)malloc((size_t)(len) * sizeof(char));

  if(num2 == NULL) {
    fprintf(stderr, "\ndynamic memory allocation failed\n");
    exit(EXIT_FAILURE);
  }

  // char num_str[5]; // result will be converted to a string and stored into 'num_str'
  //sprintf(num_str, "%f", num); // https://www.geeksforgeeks.org/what-is-the-best-way-in-c-to-convert-a-number-to-a-string/
  // printf("in system_tags here: %s\n", num_str);
  for(unsigned long long i = 0; i < len ; i += 1) { // strcpy() exhibited strange behaviour
    if(num[i] == '\n') {
      break;
    }

    num2[i] = num[i];
  }

  /*printf("num2 is: %s, len=%llu\n", num2, len);*/
  char *result = NULL;
  char *result2 = NULL;
  char *result3 = NULL;

  for(int i = 0; i < 4 ; i += 1) {
    result = replaceWord((*(flags_skeleton + i) + 0), xxxx, num2);
    result2 = replaceWord(result, yyyy, msys2path);
    result3 = replaceWord(result2, dbl_b_slash, b_slash);
    // printf("New String: %s\n", result3);
    fprintf(file01, "%s\n", result3);

    if((*consent != 0) && (i < 1)) {
      gen_tags(msys2path);
    }
  }

  for(int i = 0; i < 4 ; i += 1) {
    result = replaceWord((*(vim_tags + i) + 0), xxxx, num2);
    result2 = replaceWord(result, yyyy, msys2path);
    result3 = replaceWord(result2, dbl_b_slash, b_slash);
    /*printf("result %s\n", result3);*/
    fprintf(file02, "%s\n", result3);
  }

  for(int i = 0; i < 3 ; i += 1) {
    result = replaceWord((*(vim_tags_searchpath + i) + 0), xxxx, num2);
    result2 = replaceWord(result, yyyy, msys2path);
    result3 = replaceWord(result2, dbl_b_slash, b_slash);
    /*printf("result %s\n", result3);*/
    fprintf(file02, "%s\n", result3);
  }

  free(num2);
  num2 = NULL;
  fclose(file01);
  fclose(file02);
}

void gen_tags(char *msys2path) {
  /*
    https://docs.microsoft.com/en-us/windows/win32/fileio/changing-the-current-directory
    https://stackoverflow.com/questions/27585930/get-the-current-working-directory-in-c-on-windows
  */
  int i = 0;
  char line[5000]; /* or other suitable maximum line size */
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
  char dir_2_entr[2][100] = {
    "\\mingw64\\include",
    "\\mingw64\\include\\c++\\XXXX",
  };
  i = 0;

  do {
    totalcommand[i] = '\0';
    line[i] = '\0';
    i++;
  } while(i < 5000);

  i = 0;

  do {
    line[i] = '\0';
    i++;
  } while(i < 5000);

  char xxxx[5] = "XXXX";
  char yyyy[5] = "YYYY";
  char dbl_b_slash[4] = "\\\\"; // https://prepinsta.com/all-about-c-language/how-to-print-backslash-using-printf/
  char b_slash[2] = "\\";
  char *num;
  char *num2; // to get rid of the newline char
  num = gcc_version();
  unsigned long long len;
  len = strlen(num) - 1;
  num2 = (char *)malloc((size_t)(len) * sizeof(char));

  if(num2 == NULL) {
    fprintf(stderr, "\ndynamic memory allocation failed\n");
    exit(EXIT_FAILURE);
  }

  for(unsigned long long i = 0; i < len ; i += 1) { // strcpy() exhibited strange behaviour
    if(num[i] == '\n') {
      break;
    }

    num2[i] = num[i];
  }

  for(int count = 0; count < 2 ; count += 1) {
    if(discbrake >= 2) {
      break;
    }

    char *dir_complete_skeleton;
    dir_complete_skeleton = (char *)malloc((size_t)(300) * sizeof(char));

    if(dir_complete_skeleton == NULL) {
      fprintf(stderr, "\ndynamic memory allocation failed\n");
      exit(EXIT_FAILURE);
    }

    int j = 0;

    do {
      dir_complete_skeleton[j] = '\0';
      j++;
    } while(j < 300);

    j = 0;
    char *result = NULL;
    char *result2 = NULL;
    char *result3 = NULL;
    strcat(dir_complete_skeleton, msys2path);
    strcat(dir_complete_skeleton, dir_2_entr[count]);
    result = replaceWord(dir_complete_skeleton, xxxx, num2);
    result2 = replaceWord(result, yyyy, msys2path);
    result3 = replaceWord(result2, dbl_b_slash, b_slash);
    printf("dir: %s\n", result3);
    j = 0;

    do {
      totalcommand[j] = '\0';
      j++;
    } while(j < 15000);

    j = 0;

    do {
      line[j] = '\0';
      j++;
    } while(j < 5000);

    j = 0;
    strcat(totalcommand, _dkey);
    strcat(totalcommand, _dblamp);
    strcat(totalcommand, _cd);
    strncpy(line, result3, strlen(result3) - 1);
    strcat(totalcommand, _quote);
    strcat(totalcommand, line);
    strcat(totalcommand, _quote);
    strcat(totalcommand, _dblamp);
    strcat(totalcommand, ctagscmd);
    strcat(totalcommand, newline);
    // printf("total command: %s\n", totalcommand);
    dirswitch_n_ctags(totalcommand);
    j = 0;

    do {
      line[j] = '\0';
      j++;
    } while(j < 5000);

    j = 0;
    *result = '\0';
    *result2 = '\0';
    *result3 = '\0';
    free(dir_complete_skeleton);
    dir_complete_skeleton = NULL;
    discbrake++;
  }

  free(num2);
  num2 = NULL;
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

char *replaceWord(const char *s, const char *oldW, const char *newW) {
  // https://www.geeksforgeeks.org/c-program-replace-word-text-another-given-word/
  char *result;
  int i, cnt = 0;
  int newWlen = strlen(newW);
  int oldWlen = strlen(oldW);

  // Counting the number of times old word
  // occur in the string
  for(i = 0; s[i] != '\0'; i++) {
    if(strstr(&s[i], oldW) == &s[i]) {
      cnt++;
      // Jumping to index after the old word.
      i += oldWlen - 1;
    }
  }

  // Making new string of enough length
  result = (char *)malloc(i + cnt * (newWlen - oldWlen) + 1);
  i = 0;

  while(*s) {
    // compare the substring with the result
    if(strstr(s, oldW) == s) {
      strcpy(&result[i], newW);
      i += newWlen;
      s += oldWlen;
    }

    else {
      result[i++] = *s++;
    }
  }

  result[i] = '\0';
  return result;
}

