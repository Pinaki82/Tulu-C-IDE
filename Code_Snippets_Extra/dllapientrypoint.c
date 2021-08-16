#include <windows.h>

//Platform specific macro for clear declaration of APIENTRY of dll on _WIN32 only
#ifndef _WIN32
#undef __WINDOWS_H__
#undef DLL_EXPORT
#endif

/*
 * This is just an APIENTRYPOINT to the dll, on _WIN32 Platform.
 * Just #include <this_header> into your main dll source file.
*/
BOOL APIENTRY DllMain(
						HMODULE hModule, /* Library instance Module. */
						DWORD ul_reason_for_call, /* Reason this function is being called. */
						LPVOID lpReserved /* Not used. */
					) {
 switch (ul_reason_for_call) {
  case DLL_PROCESS_ATTACH:
  case DLL_THREAD_ATTACH:
  case DLL_THREAD_DETACH:
  case DLL_PROCESS_DETACH:
	  break;
 }
 /* Returns TRUE on success, FALSE on failure */
 return TRUE;
}


