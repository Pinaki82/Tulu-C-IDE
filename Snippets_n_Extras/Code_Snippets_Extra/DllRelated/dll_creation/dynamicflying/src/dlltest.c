#include "dlltest.h"
//--------------------- these lines are not mandatory -----------------//
// #define MAXMODULE 50

// char module[MAXMODULE];

//-------------------- ******* -----------------------//


void DLL_EXPORT cat() {
//--------------------- these lines are not mandatory -----------------//
        // GetModuleFileName(NULL, (LPTSTR)module, MAXMODULE);

        // printf("\n\nThis function was called from %s ",module);

        // printf("cat(); \n");
//-------------------- ******* -----------------------//

       printf("I'm in cat();\n");
}

void DLL_EXPORT dog() {
//--------------------- these lines are not mandatory -----------------//
        // GetModuleFileName(NULL, (LPTSTR)module, MAXMODULE);

        // printf("\n\nThis function was called from %s ",module);

        // printf("dog(); \n");
//-------------------- ******* -----------------------//

       printf("I'm in dog();\n");
 }
