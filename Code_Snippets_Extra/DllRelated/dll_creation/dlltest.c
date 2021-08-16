#include "dlltest.h"
#include<strings.h>

#define MAXMODULE 50

char module[MAXMODULE];
int i;

void __declspec(dllexport) NumberList() {

       GetModuleFileName(NULL, (LPTSTR)module, MAXMODULE);

       printf("\n\nThis function was called from %s ",module);

       printf("NumberList(): ");


       for(i=0;  i<10; i++) {

            printf("%d ",i);
       }
}

void __declspec(dllexport) LetterList() {

       GetModuleFileName(NULL, (LPTSTR)module, MAXMODULE);

       printf("\n\nThis function was called from %s ",module);

       printf("LetterList(): ");


       for(i=0;  i<26; i++) {

            printf("%c ",(97 + i));
       }
 }
