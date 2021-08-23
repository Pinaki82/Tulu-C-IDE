#include "dll.h"
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

main()
{
 HelloWorld ();
 getchar();
 return 0;
}
/*
Linker:
-mwindows
Output/MingW/libdefault_dll.a
*/
