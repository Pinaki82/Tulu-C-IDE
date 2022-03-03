# =========================================================================
#     This makefile was generated by
#     Bakefile 0.2.9 (http://www.bakefile.org)
#     Do not modify, all changes will be overwritten!
# =========================================================================



# -------------------------------------------------------------------------
# These are configurable options:
# -------------------------------------------------------------------------

# C compiler 
CC = cl

# Standard flags for CC 
CFLAGS = 

# Standard preprocessor flags (common for CC and CXX) 
CPPFLAGS = 

# Standard linker flags 
LDFLAGS = 



# -------------------------------------------------------------------------
# Do not modify the rest of this file!
# -------------------------------------------------------------------------

### Variables: ###

EASY_DLL_CFLAGS =  /MD /DWIN32 /D_WINDLL   /TC /W4 $(CPPFLAGS) $(CFLAGS)
EASY_DLL_OBJECTS =  \
	easy_dll_easy_dll.obj
EASY_DLL_RESOURCES =  \
	easy_dll_resource.res

### Conditionally set variables: ###



### Targets: ###

all: easy_dll.dll

clean: 
	-if exist .\*.obj del .\*.obj
	-if exist .\*.res del .\*.res
	-if exist .\*.pch del .\*.pch
	-if exist easy_dll.dll del easy_dll.dll
	-if exist easy_dll.ilk del easy_dll.ilk
	-if exist easy_dll.pdb del easy_dll.pdb
	-if exist easy_dll.lib del easy_dll.lib

easy_dll.dll: $(EASY_DLL_OBJECTS) easy_dll_resource.res
	link /DLL /NOLOGO /OUT:$@  $(LDFLAGS) @<<
	$(EASY_DLL_OBJECTS) $(EASY_DLL_RESOURCES)  user32.lib kernel32.lib shell32.lib gdi32.lib comctl32.lib ole32.lib
	winmm.lib /IMPLIB:easy_dll.lib
<<

easy_dll_resource.res: .\..\source\resource.rc
	rc /fo$@  /d WIN32 /d _WINDLL .\..\source\resource.rc

easy_dll_easy_dll.obj: .\..\source\easy_dll.c
	$(CC) /c /nologo /TC /Fo$@ $(EASY_DLL_CFLAGS) .\..\source\easy_dll.c
