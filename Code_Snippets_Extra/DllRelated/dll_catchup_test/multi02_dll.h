#ifndef MULTI02_DLL_H__
#define MULTI02_DLL_H__
#if BUILDING_DLL
# define DLLIMPORT __declspec (dllexport)
#else /* Not BUILDING_DLL */
# define DLLIMPORT __declspec (dllimport)
#endif /* Not BUILDING_DLL */


DLLIMPORT void func_multi02_dll(
);

#endif
//http://www.adp-gmbh.ch/win/misc/mingw/dll.html
/*
Google Search:
create dll using mingw
*/
