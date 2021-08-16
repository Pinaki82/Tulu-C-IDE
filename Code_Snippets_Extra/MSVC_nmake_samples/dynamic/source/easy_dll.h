#ifndef __EASY_DLL_H__
#define __EASY_DLL_H__
						/*Step 1: Header definition:
						To use all the exported functions from the dll, include this header
						in your project.*/

///////////////////////////////////////////////////////////////////////////////////////////////////////
#if !defined(__DMC__) && defined(__TINYC__)
	#include <windows.h>
#endif
/*In "Digital Mars compiler" windows.h must not be included in the dll-header.
But in "Tiny C compiler" windows.h must be included  in the dll-header.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////Step 2: BUILD_DLL Definition://///////////////////////////////////////////////////////////////
///////This term is to be memorized to create dll header/////////////////////////////////////////////////////////////

#if BUILDING_DLL || _WINDLL || BUILD_DLL      /* _WINDLL is VC++ IDE specific, already defined there, similarly BUILDING_DLL for DEVC++, BUILD_DLL for Code::Blocks */
    #define DLL_EXPORT __declspec(dllexport)
#else
    #define DLL_EXPORT __declspec(dllimport)
#endif
/////////////////////write upto this. this is the definition to build a dll. End of Step 3:///////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////Step 3: _cplusplus Definition + your functions PROTOTYPE DECLARATION ///////////////////
////////////////////////////Remember these steps rhythm writing several times ///////////////////////////////////////
#ifdef __cplusplus
extern "C"
{
#endif

int DLL_EXPORT func_multi01_dll (); //your functions prototype declaration
// void DLL_EXPORT another_function();
#ifdef __cplusplus
}
#endif

#endif // __EASY_DLL_H__
	   //"easy_dll.h"
	  //write these for your reference.

/*
The dllexport and dllimport storage-class attributes are
Microsoft-specific extensions to the C and C++ languages.
They enable you to export and import functions, data,
and objects to and from a DLL.
export import -->> to and from a DLL
*/

/*
Now you need to setup your compiler:
mingw32-gcc.exe -Wextra -Wall -Wextra -Wall -g -DBUILD_DLL -DBUILDING_DLL=1 -Wall
				-c D:\Code_Blocks\DLL_CB\src\arrowkey.c -o ..\obj\Debug\src\arrowkey.o
mingw32-g++.exe -shared -Wl,--output-def=..\bin\Debug\libarrowkey.dll.def
				-Wl,--out-implib=..\bin\Debug\libarrowkey.dll.a
				-Wl,--dll ..\obj\Debug\src\arrowkey.o
				-o ..\bin\Debug\arrowkey.dll
				--no-export-all-symbols
				-Wl,--add-stdcall-alias -luser32
Creating library file: ..\bin\Debug\libarrowkey.dll.a

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

