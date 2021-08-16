// Last Change: 2013-05-08 00:38:22
/* An Example to open any text file with fopen() */
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
  FILE *pFile; /* file pointer */
  char mystring [100]; /* maximum characters in the input file must not exceed
                            100 */
  char myfilename [100];  /* required by the filename with extension */
  /*int i=0;*/ /* necessary when counting inside the loop */

  printf("\nEnter a file name: ");
  *myfilename=fflush(stdin); /* flushes the buffer */
  scanf("%s", myfilename);

  pFile = fopen(myfilename, "r"); /* NOTE: don't write fopen("myfilename", "r"); */
  /* This opens the file */ /* The main concept is to pass the base address of the
          string (here myfilename) and not the string itself, since the
          arguments are (const char * filename, const char * mode), it expects
          the addresses rather than the formatted strings.
          We should also remember that the formatted strings also serve
          the same purpose of passing the base address here  and vice-versa.
          In absence of the exact filename we are adopting the
          base address passing method, this is the only option here */
  if(pFile == NULL) {  /* Checks whether the file exists or not */
    perror("Error opening file");
  }
  else {
    if(feof(pFile)) {
      puts("\nEnd-of-File reached.\n");
      fclose(pFile);
    }
    else
      do {
        /*printf("i=%d\n",i);*/
        if(fgets(mystring , 100 , pFile) != NULL) { /*Reads and displays the file*/
          /*puts(mystring);*/  /* NOTE: puts creates new line after every line */
          printf("%s",mystring);
        }
        if(feof(pFile)) {
          puts("\nEnd-of-File reached.");
          fclose(pFile);
          break;
        }
        /*i++;*/
      }
      while(1);
    /*fclose(pFile);*/ /* NOTE: here it's not necessary */
  }
  system("PAUSE");
  return EXIT_SUCCESS;
}

