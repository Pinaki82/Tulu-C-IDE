#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

// #define MAXMODULE 50 /* this is not mandatory */

typedef int (WINAPI*c_my_func)(); // typedef void (WINAPI*c_my_func2)(); etc. etc. etc.

c_my_func func_multi01_dll;
// c_my_func another_function(); /* another function of your choice, you can add more fn. */

int main(void) {
 int returned_value;
       HINSTANCE h_my_Lib_or_nythng=LoadLibrary("easy_dll.dll");
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

       func_multi01_dll=(c_my_func)GetProcAddress((HMODULE)h_my_Lib_or_nythng, "func_multi01_dll");
   //  another_function=(c_my_func)GetProcAddress((HMODULE)h_my_Lib_or_nythng, "dog"); /* rule for writing other functions. */

       if((func_multi01_dll==NULL)) { /* if((cat==NULL) || (dog==NULL)) {} // connect using "OR*. */

            printf("Unable to load function(s).");
            FreeLibrary((HMODULE)h_my_Lib_or_nythng);
            return 0;
       }

       returned_value=func_multi01_dll();
    // another_function(); /* write other functions.*/

       FreeLibrary((HMODULE)h_my_Lib_or_nythng);

       printf("returned value from dll=%d\n",returned_value);
       printf("\n");
	   system("PAUSE");
	   return 0;
 }
