// Last Change: 2020-11-15  Sunday: 06:57:05 PM
#include <iostream>

int main() {
  int *uninitialised_var;
  std::cin >> *uninitialised_var >> std::endl; /* illegal attemp of storing
              an inintitialised integer ptr without an address from user input */
  fflush(stdin);
  return EXIT_SUCCESS;
}
