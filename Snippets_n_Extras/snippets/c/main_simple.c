// A rudimentary main() function template in C.
#include <stdio.h> // includes standard input/output library
#include <stdlib.h> // includes standard library for C, which provides functions for memory allocation
#include <string.h> // includes standard library for C, which provides functions for string manipulation

#define VERSION "1.0" // defines a constant string called "VERSION" with the value "1.0"
#define NO_OF_ARGS 3 // the exact no. of command-line arguments the program takes

int main(int argc, char *argv[]) { // The Main function. argc means the number of arguments. argv[0] is the program name. argv[1] is the first argument. argv[2] is the second argument and so on.
  printf("Hey! %s here!\n", argv[0]); // Displays the program's name

  if(argc == 2 && strcmp(argv[1], "--version") == 0) {  // checks if the program was called with the argument "--version". If it was, it prints out the value of the "VERSION" constant and returns 0. Otherwise, it slides down to the next `else if()` block.
    printf("%s\n", VERSION);
    return 0;
  }

  else if(argc == 2 && strcmp(argv[1], "--version") != 0) { // checks if the program was called with only ONE argument and the argument was not "--version". In that case, it displays an error message and exits with a return value of 1.
    printf("Unknown argument! The program will exit!!\n");
    exit(1);
  }

  if(argc != NO_OF_ARGS) {  // Checks if the program was called with the exact number of arguments. If it wasn't, it prints out an error message and returns 1.
    printf("Please provide %d arguments\n", (NO_OF_ARGS - 1));
    return 1;
  }

  // After performing all checks, your code starts here
  printf("First argument: %s\n", argv[1]); // prints out the first argument passed to the program
  printf("Second argument: %s\n", argv[2]); // prints out the second argument passed to the program
  return 0;
}
