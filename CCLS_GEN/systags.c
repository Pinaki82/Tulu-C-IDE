// Last Change: 2022-08-29  Monday: 02:16:34 AM

/*
  Compilation (Debug): gcc -g -Wall -Wextra -pedantic -fstack-protector-all systags.c -o systags
  Use (GDB):  gdb systags
  Compilation: gcc -O2 -Wall -Wextra -pedantic -fstack-protector-all systags.c -o systags -s
  Use: ./systags
  Then rename the generated files:
  .ccls
  compile_flags.txt
*/

/*
  Installation:
  BASH Shell:
  Open $HOME/.bashrc or $HOME/.bash_aliases with a text editor and
  paste the following line in the beginning:
  export PATH="$HOME/.local/bin/:$PATH"
  Fish Shell:
  Open $HOME/.config/fish/config.fish with a text editor and
  paste the following lines in the beginning:
  # --------------
  # $HOME/.local/bin
  export PATH="$HOME/.local/bin/:$PATH"
  export PATH
  # --------------
  Run: source $HOME/.config/fish/config.fish to reload the configuration.
  Now, compile this program and run the command given below.
  install -m 755 systags $HOME/.local/bin
  Use: Enter a directory, then run 'systags' without quotes.
*/

// Restrict to UNIX-like systems only
#if !( defined( __unix__ ) || defined(_POSIX_VERSION) )
  #error "For UNIX-like Operating Systems Only"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <stdint.h>
#include <unistd.h>

int gcc_version(void);
void compile_flags(void);
void ccls(int *consent);
char *replaceWord(const char *s, const char *oldW, const char *newW);

int main(void) {
  int yesno = 0;
  printf("To generate tags db in system's include directories you'll need admin privilege.\n");
  printf("0 (zero) means NO. 1 (one) means YES.\n");
  printf("Do you want to generate tags db with ctags as well? (1/0)\n");
  scanf("%d", &yesno);
  compile_flags();
  ccls(&yesno);
  return 0;
}

int gcc_version(void) {
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
    sscanf(line, "%d", &version); /* https://www.tutorialspoint.com/converting-strings-to-numbers-in-c-cplusplus */
    // printf("%d\n", version); // version number is now stored into 'version'
    i++;
  }

  system("rm gccdumpver.txt");
  fclose(fp);
  return version;
}

void compile_flags(void) {
  static const char filename01[] = "linuxsys-compile_flags.txt";
  FILE *fp1;

  if((fp1 = fopen("linuxsys-compile_flags.txt", "r")) != NULL) { // file exists
    system("rm linuxsys-compile_flags.txt");
  }

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
    "x86_64-pc-linux-gnu",
    "",
  };
  char cmpl_flags_skeleton02[7][100] = {
    "-isystem /usr/include/c++/XXXX",
    "-isystem /usr/include/x86_64-linux-gnu/c++/XXXX",
    "-isystem /usr/include/c++/XXXX/backward",
    "-isystem /usr/lib/gcc/x86_64-linux-gnu/XXXX/include",
    "-isystem /usr/local/include",
    "-isystem /usr/include/x86_64-linux-gnu",
    "-isystem /usr/include",
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
  int num = gcc_version();
  char num_str[5]; // result will be converted to a string and stored into 'num_str'
  sprintf(num_str, "%d", num); // https://www.geeksforgeeks.org/what-is-the-best-way-in-c-to-convert-a-number-to-a-string/
  // printf("in system_tags here: %s\n", num_str);
  char *result = NULL;

  for(int i = 0; i < 7 ; i += 1) {
    result = replaceWord((*(cmpl_flags_skeleton02 + i) + 0), xxxx, num_str);
    // printf("New String: %s\n", result);
    fprintf(file01, "%s\n", result);
  }

  fclose(file01);
}

void ccls(int *consent) {
  FILE *fp4;

  if((fp4 = fopen("linuxsys.ccls.txt", "r")) != NULL) { // file exists
    system("rm linuxsys.ccls.txt");
  }

  static const char filename01[] = "linuxsys.ccls.txt";
  FILE *file01 = fopen(filename01, "w");

  if(file01 == NULL) {  // checking for errors
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
    "%c x86_64-pc-linux-gnu",
    "",
    "",
  };
  char flags_skeleton[7][100] = {
    "-isystem /usr/include/c++/XXXX",
    "-isystem /usr/include/x86_64-linux-gnu/c++/XXXX",
    "-isystem /usr/include/c++/XXXX/backward",
    "-isystem /usr/lib/gcc/x86_64-linux-gnu/XXXX/include",
    "-isystem /usr/local/include",
    "-isystem /usr/include/x86_64-linux-gnu",
    "-isystem /usr/include",
  };
  char dir_2_entr[7][400] = {
    "cd /usr/include/c++/XXXX && sudo ctags -R --sort=yes --c-kinds=+pxfvtdeglmsu --c++-kinds=+pxfvtdeglmsu --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+iaSmz --extras=+qf -I \"_GLIBCXX_BEGIN_NAMESPACE_VERSION _GLIBCXX_END_NAMESPACE_VERSION _GLIBCXX_VISIBILITY+\" -f tags * ",
    "cd /usr/include/x86_64-linux-gnu/c++/XXXX && sudo ctags -R --sort=yes --c-kinds=+pxfvtdeglmsu --c++-kinds=+pxfvtdeglmsu --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+iaSmz --extras=+qf -I \"_GLIBCXX_BEGIN_NAMESPACE_VERSION _GLIBCXX_END_NAMESPACE_VERSION _GLIBCXX_VISIBILITY+\" -f tags * ",
    "cd /usr/include/c++/XXXX/backward && sudo ctags -R --sort=yes --c-kinds=+pxfvtdeglmsu --c++-kinds=+pxfvtdeglmsu --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+iaSmz --extras=+qf -I \"_GLIBCXX_BEGIN_NAMESPACE_VERSION _GLIBCXX_END_NAMESPACE_VERSION _GLIBCXX_VISIBILITY+\" -f tags * ",
    "cd /usr/lib/gcc/x86_64-linux-gnu/XXXX/include && sudo ctags -R --sort=yes --c-kinds=+pxfvtdeglmsu --c++-kinds=+pxfvtdeglmsu --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+iaSmz --extras=+qf -I \"_GLIBCXX_BEGIN_NAMESPACE_VERSION _GLIBCXX_END_NAMESPACE_VERSION _GLIBCXX_VISIBILITY+\" -f tags * ",
    "cd /usr/local/include && sudo ctags -R --sort=yes --c-kinds=+pxfvtdeglmsu --c++-kinds=+pxfvtdeglmsu --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+iaSmz --extras=+qf -I \"_GLIBCXX_BEGIN_NAMESPACE_VERSION _GLIBCXX_END_NAMESPACE_VERSION _GLIBCXX_VISIBILITY+\" -f tags * ",
    "cd /usr/include/x86_64-linux-gnu && sudo ctags -R --sort=yes --c-kinds=+pxfvtdeglmsu --c++-kinds=+pxfvtdeglmsu --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+iaSmz --extras=+qf -I \"_GLIBCXX_BEGIN_NAMESPACE_VERSION _GLIBCXX_END_NAMESPACE_VERSION _GLIBCXX_VISIBILITY+\" -f tags * ",
    "cd /usr/include && sudo ctags -R --sort=yes --c-kinds=+pxfvtdeglmsu --c++-kinds=+pxfvtdeglmsu --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+iaSmz --extras=+qf -I \"_GLIBCXX_BEGIN_NAMESPACE_VERSION _GLIBCXX_END_NAMESPACE_VERSION _GLIBCXX_VISIBILITY+\" -f tags * ",
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
  int num = gcc_version();
  char num_str[5]; // result will be converted to a string and stored into 'num_str'
  sprintf(num_str, "%d", num); // https://www.geeksforgeeks.org/what-is-the-best-way-in-c-to-convert-a-number-to-a-string/
  // printf("in system_tags here: %s\n", num_str);
  char *result = NULL;

  for(int i = 0; i < 7 ; i += 1) {
    result = replaceWord((*(flags_skeleton + i) + 0), xxxx, num_str);
    // printf("New String: %s\n", result);
    fprintf(file01, "%s\n", result);

    if(*consent != 0) {
      result = replaceWord((*(dir_2_entr + i) + 0), xxxx, num_str);
      printf("\nGenerating tags... The command passed is: %s\n", result);
      system(result);
    }
  }

  fclose(file01);
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

