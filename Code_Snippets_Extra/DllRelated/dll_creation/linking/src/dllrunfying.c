#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

#define MAXMODULE 50

typedef void (WINAPI*cfunc)();

cfunc NumberList;
cfunc LetterList;

int main(void) {

       HINSTANCE hLib=LoadLibrary("CBDYNA.DLL");
                        /*You can use relative paths like: "../../CBDYNA.DLL" or,
                        absolute path like: "D:/Code_Blocks/linking/CBDYNA.DLL" but
						be sure to use normal-SLASH not back-slash. */

       if(hLib==NULL) {

            printf("Unable to load library!");
            getchar();
            return 0;
       }

       char mod[MAXMODULE];

       GetModuleFileName((HMODULE)hLib, (LPTSTR)mod, MAXMODULE);
       printf("Library loaded: ");


       NumberList=(cfunc)GetProcAddress((HMODULE)hLib, "NumberList");
       LetterList=(cfunc)GetProcAddress((HMODULE)hLib, "LetterList");

       if((NumberList==NULL) || (LetterList==NULL)) {

            printf("Unable to load function(s).");
            FreeLibrary((HMODULE)hLib);
            return 0;
       }

       NumberList();
       LetterList();

       FreeLibrary((HMODULE)hLib);

       printf("\n");
	   system("PAUSE");
	   return 0;
 }
