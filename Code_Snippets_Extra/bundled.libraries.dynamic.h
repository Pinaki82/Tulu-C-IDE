#ifndef __BUNDLED_LIBRARIES_DYNAMIC_H__
#define __BUNDLED_LIBRARIES_DYNAMIC_H__
						/*Step 1: Header definition:
						To use this exported function of dll, include this header
						"*.h" in your project.*/

				/*Step 2: Library Inclusion:
				include necessary standard/3-rd-party libraries to create a dll header.*/
///////////////////////////////////////////////////////////////////////////////////////////////////////
#if !defined(__DMC__) && defined(__TINYC__)
	#include <windows.h>
#endif
/*In "Digital Mars compiler" windows.h must not be included in the dll-header.
But in "Tiny C compiler" windows.h must be included  in the dll-header.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////Step 3: BUILD_DLL Definition://///////////////////////////////////////////////////////////////
///////This term is to be memorized to create dll header/////////////////////////////////////////////////////////////
#ifdef BUILD_DLL
    #define DLL_EXPORT __declspec(dllexport)
#else
    #define DLL_EXPORT __declspec(dllimport)
#endif /////////////////////write upto this. this is the definition to build a dll. End of Step 3:///////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////Step 4: _cplusplus Definition + your functions PROTOTYPE DECLARATION ///////////////////
////////////////////////////Remember these steps rhythm writing several times ///////////////////////////////////////
#ifdef __cplusplus
extern "C"
{
#endif

double DLL_EXPORT FuncA(double a, double b); //your functions prototype declaration //use this as: z=FuncA(x,y);
double DLL_EXPORT FuncB(double a, double b); //your functions prototype declaration //use this as: o=FuncB(m,n);

#ifdef __cplusplus
}
#endif

#endif // __BUNDLED_LIBRARIES_DYNAMIC_H__
	   //"bundled.libraries.dynamic.h"
	  //write these for your reference.

/*
Now you need to setup your compiler:
mingw32-gcc.exe -Wextra -Wall -Wextra -Wall -g -DBUILD_DLL -DBUILDING_DLL=1 -Wall
				-c D:\Code_Blocks\DLL_CB\src\*.c -o ..\obj\Debug\src\*.o
mingw32-g++.exe -shared -Wl,--output-def=..\bin\Debug\lib*.dll.def
				-Wl,--out-implib=..\bin\Debug\lib*.dll.a
				-Wl,--dll ..\obj\Debug\src\*.o
				-o ..\bin\Debug\*.dll
				--no-export-all-symbols
				-Wl,--add-stdcall-alias -luser32
Creating library file: ..\bin\Debug\lib*.dll.a

Or, it may be:
Link Libraries:
user32

Other Linker Options:
--no-export-all-symbols
-Wl,--add-stdcall-alias

Compiler Settings:
#defines:
BUILD_DLL
BUILDING_DLL=1
*/

