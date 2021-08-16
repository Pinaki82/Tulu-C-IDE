#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

// #define MAXMODULE 50 /* this is not mandatory */

typedef void (WINAPI*c_my_func)();

c_my_func cat;
c_my_func dog;

int main(void) {

       HINSTANCE h_my_Lib_or_nythng=LoadLibrary("CBDYNA.DLL");
                        /*You can use relative paths like: "../../CBDYNA.DLL" or,
                        absolute path like: "D:/Code_Blocks/linking/CBDYNA.DLL" but
						be sure to use normal-SLASH not back-slash. */

       if(h_my_Lib_or_nythng==NULL) {

            printf("Unable to load library!\n");
            getchar();
            return 0;
       }
//--------------------- these lines are not mandatory -----------------//
       // char mod[MAXMODULE];

       // GetModuleFileName((HMODULE)h_my_Lib_or_nythng, (LPTSTR)mod, MAXMODULE);
       // printf("Library loaded: \n");
//-------------------- ******* -----------------------//

       cat=(c_my_func)GetProcAddress((HMODULE)h_my_Lib_or_nythng, "cat");
       dog=(c_my_func)GetProcAddress((HMODULE)h_my_Lib_or_nythng, "dog");

       if((cat==NULL) || (dog==NULL)) {

            printf("Unable to load function(s).");
            FreeLibrary((HMODULE)h_my_Lib_or_nythng);
            return 0;
       }

       cat();
       dog();

       FreeLibrary((HMODULE)h_my_Lib_or_nythng);

       printf("\n");
	   system("PAUSE");
	   return 0;
 }
