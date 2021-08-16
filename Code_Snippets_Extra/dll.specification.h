/*
for some older dll if there is no APIENTRY pointer to DllMain(),
you can includes this header to such old dll code, just in the '.c' section of the dll.
***Do not include this into the '.h' part of the dll.***
*/

#ifndef __DLL_SPECIFICATION_H__
#define __DLL_SPECIFICATION_H__

#if defined(__DMC__) && !( defined(__TINYC__) || defined(__MINGW32__) || defined(_MSC_VER) )
  #include <windows.h>
  #include <stdio.h>
  #include <stdlib.h>
#endif

#ifdef __cplusplus
extern "C"
{
#endif

BOOL APIENTRY DllMain (HINSTANCE hInst     /* Library instance handle. */ ,
                       DWORD reason        /* Reason this function is being called. */ ,
                       LPVOID reserved     /* Not used. */ )
{
    switch (reason)
    {
      case DLL_PROCESS_ATTACH:
        break;

      case DLL_PROCESS_DETACH:
        break;

      case DLL_THREAD_ATTACH:
        break;

      case DLL_THREAD_DETACH:
        break;
    }

    /* Returns TRUE on success, FALSE on failure */
    return TRUE;
}

#ifdef __cplusplus
}
#endif
#endif //__DLL_SPECIFICATION_H__
		// "dll.specification.h"

