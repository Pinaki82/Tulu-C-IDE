// Last Change: 2022-09-14  Wednesday: 11:00:25 AM
#ifndef  __DUPREM_H__
#define  __DUPREM_H__

#if defined( MAX_LENGTH_OF_INOUTSTR )
  #undef MAX_LENGTH_OF_INOUTSTR
#endif

#define MAX_LENGTH_OF_INOUTSTR 10000

#include <windows.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>

#ifdef __cplusplus
extern "C" {
#endif

void duplinerm(char *flnm, char *fl2write); // read as: dup line rm
/*
  Call duplinerm()
  from your main()
  as follows:
  char file2opn[]="sorted.txt";
  char outfile[]="final_sorting.txt";
  duplinerm(file2opn, outfile);
*/

#ifdef __cplusplus
}
#endif

#endif  /* __DUPREM_H__ */

void duplinerm(char *flnm, char *fl2write) {
  unsigned int count = 0;
  unsigned int linesCount = 0;
  int compared = 0;
  char line[MAX_LENGTH_OF_INOUTSTR];
  char ch;
  char **page;
  FILE *fp2, *fp3;
  count = 0;

  while(count < MAX_LENGTH_OF_INOUTSTR) {
    line[count] = '\0';
    count++;
  }

  count = 0;
  fp2 = fopen(flnm, "r"); // open & append to file

  if(fp2 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  while((ch = fgetc(fp2)) != EOF) {
    if(ch == '\n') {
      linesCount++;
    }
  }

  //printf("linesCount %u\n", linesCount);
  fclose(fp2); // closing file
  fp3 = fopen(fl2write, "w"); // open & append to file
  fclose(fp3); // closing file
  char *filename02 = flnm;
  FILE *file02 = fopen(filename02, "r");
  char *filename01 = fl2write;
  FILE *file01 = fopen(filename01, "a+");

  if(file01 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  page = (char **)malloc((size_t)linesCount * sizeof(char *)); /* memory allocation,
                                                            row basis */

  if(page == NULL) {
    printf("\ndynamic memory allocation failed\n");
    exit(EXIT_FAILURE);
  }

  for(unsigned int i = 0; i <= linesCount - 1; i++) {
    page[i] = (char *)malloc((size_t)MAX_LENGTH_OF_INOUTSTR * sizeof(char));  /* memory allocation,
                                                            column basis */

    if(page[i] == NULL) {
      printf("\ndynamic memory allocation failed\n");
      exit(EXIT_FAILURE);
    }
  }

  for(unsigned int i = 0; i <= linesCount - 1; i++) {
    for(unsigned int j = 0; j <= MAX_LENGTH_OF_INOUTSTR - 1; j++) {
      page[i][j] = '\0'; /* filling the entire array with a NULL */
    }
  }

  count = 0;

  while(count < MAX_LENGTH_OF_INOUTSTR) {
    line[count] = '\0';
    count++;
  }

  count = 0;
  unsigned int i = 0, j = 0;

  while(fgets(line, sizeof line, file02) != NULL) { /* read a line */
    strcpy((*(page + i)) + j, line);
    i++;
  }

  //printf("\nyour input was:\n");
  /*
    for(i = 0; i <= linesCount - 1 ; i++) {
      //printf("%d.%d. page=%s\n", i, j, (*(page + i) + j)); // NOTE: Note that arr[i][j] is same as *(*(arr+i)+j)
    }
  */
  fp3 = fopen(fl2write, "w"); // open & append to file

  if(fp3 == NULL) {  // checking for errors
    printf("couldn't open the \n");
    exit(EXIT_FAILURE);
  }

  unsigned int **dupmatrx;
  dupmatrx = (unsigned int **)malloc((size_t)linesCount * sizeof(unsigned int *));  /* memory allocation,
                                                            row basis */

  if(dupmatrx == NULL) {
    printf("\ndynamic memory allocation failed\n");
    exit(EXIT_FAILURE);
  }

  for(i = 0; i < linesCount; i++) {
    dupmatrx[i] = (unsigned int *)malloc((size_t)2 * sizeof(unsigned int));  /* memory allocation,
                                                            column basis */

    if(dupmatrx[i] == NULL) {
      printf("\ndynamic memory allocation failed\n");
      exit(EXIT_FAILURE);
    }
  }

  for(i = 0; i < linesCount; i++) {
    for(j = 0; j < 2; j++) {
      dupmatrx[i][j] = 0; /* filling the entire array with a NULL */
    }
  }

  unsigned int k = 0;

  for(i = 0; i < linesCount ; i += 1) {
    //printf("i=%d, line: %s\n", i, *(page + i));
    for(k = 0; (k < linesCount) && (i != k); k += 1) {
      compared = strcmp(*(page + i), *(page + k));

      if(compared == 0) {
        //printf("Found a match @ i=%d, k=%d. line: %s\n", i, k, *(page + i));
        *(*(dupmatrx + i) + 0) = i;
        *(*(dupmatrx + i) + 1) = k;
        //printf("i=%d\n", dupmatrx[i][0]);
        //printf("k=%d\n", dupmatrx[i][1]);
        break;
      }
    }

    //printf("%s", *(page + i));
  }

  //printf("\ndupmatrx found:\n");

  for(i = 0, j = 1; i < linesCount ; i++) {
    /*
      if((dupmatrx[i][0] * dupmatrx[i][1]) != 0) {
        //printf("a dup line found here (will be skipped):\ni=%d, j=%d, dupmatrx=%d.%d, i.e., %d.%d\n", i, j, dupmatrx[i][0], dupmatrx[i][1], 1 + dupmatrx[i][0], 1 + dupmatrx[i][1]); // NOTE: Note that arr[i][j] is same as *(*(arr+i)+j)
      }
    */
    /*
        else {
          //printf("will be written to th dsk:\n%s", page[i]);
          fprintf(fp3, "%s", page[i]);
        }
    */
    fprintf(fp3, "%s", page[i]);
  }

  for(unsigned int i = 0; i <= linesCount - 1; i++) {
    free(page[i]); /* very much essential */
    page[i] = NULL;
  }

  free(page); /* very much essential */
  page = NULL;

  for(i = 0; i <= linesCount - 1; i++) {
    free(dupmatrx[i]); /* very much essential */
    dupmatrx[i] = NULL;
  }

  free(dupmatrx); /* very much essential */
  dupmatrx = NULL;
  fclose(fp3);
  fclose(file01);
  fclose(file02); // closing file
}

