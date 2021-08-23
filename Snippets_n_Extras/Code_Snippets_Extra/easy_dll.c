#include "easy_dll.h"
				/*JUST include the DLL HEADER*/
///////////////////////Step 2: DllMain(){} with standard headers included://///////////////////////////////////////////
///////The steps are to be memorized to create a dll file/////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  #include <windows.h> //always include this.
  #include <stdio.h>
  #include <stdlib.h>
	/*Include other headers*/

/* Digital Mars compiler only supports including windows.h and everything in the dll-body's '.c' file
and never in the '.h', but some compilers may recommend including windows.h in the dll-body's header part,
but does not generally reports an error if the order is altered.*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

BOOL APIENTRY DllMain( HMODULE hModule,             /* Library instance Module. */
                       DWORD  ul_reason_for_call,   /* Reason this function is being called. */
                       LPVOID lpReserved            /* Not used. */
					 )
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
	
	/* Returns TRUE on success, FALSE on failure */
	return TRUE;
}

///////write upto this. dll's APIENTRY-POINT is mandatory to attach/detach a dll, according to the Microsoft definition. End of Step 2://
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//--------------------- these lines are not mandatory -----------------//
// #define MAXMODULE 50

// char module[MAXMODULE];

//-------------------- ******* -----------------------//


int DLL_EXPORT func_multi01_dll (){ /*int DLL_EXPORT function_with_code. */
int i;

//--------------------- these lines are not mandatory -----------------//
        // GetModuleFileName(NULL, (LPTSTR)module, MAXMODULE);

        // printf("\n\nThis function was called from %s ",module);

        // printf("func_multi01_dll (); \n");
//-------------------- ******* -----------------------//

 for (i=1; i<=10; i+=1) {
   printf("%d. I am in multi01..\n",i);
 }
 getchar();
 return 2*i;
}


/*
void DLL_EXPORT another_function() {
//--------------------- these lines are not mandatory -----------------//
        // GetModuleFileName(NULL, (LPTSTR)module, MAXMODULE);

        // printf("\n\nThis function was called from %s ",module);

        // printf("another_function(); \n");
//-------------------- ******* -----------------------//

       printf("I'm in another_function();\n");
 }

*/

