#include<stdio.h>
#include<stdlib.h>
#include "scancode_appu.h"

int main(void) {
  int returned;
  while(1) {
    returned=scncd();
    printf("%d\n",returned);
  }
}

