# =========================================================================
#     This makefile was generated by
#     Bakefile 0.2.9 (http://www.bakefile.org)
#     Do not modify, all changes will be overwritten!
# =========================================================================



# -------------------------------------------------------------------------
# These are configurable options:
# -------------------------------------------------------------------------

# C compiler 
CC = dmc

# Standard flags for CC 
CFLAGS = -HP99

# Standard preprocessor flags (common for CC and CXX) 
CPPFLAGS = 

# Standard linker flags 
LDFLAGS = 



# -------------------------------------------------------------------------
# Do not modify the rest of this file!
# -------------------------------------------------------------------------

### Variables: ###

RANDXMPL05_CFLAGS =    -W- -A -H -s -o -O $(CPPFLAGS) $(CFLAGS)
RANDXMPL05_OBJECTS =  \
	randxmpl05_randxmpl05.obj

### Targets: ###

all : randxmpl05.exe

clean : 
	-if exist .\*.obj del .\*.obj
	-if exist .\*.res del .\*.res
	-if exist .\*.sym del .\*.sym
	-if exist randxmpl05.exe del randxmpl05.exe
	-if exist randxmpl05.map del randxmpl05.map

randxmpl05.exe : $(RANDXMPL05_OBJECTS)
	link /NOLOGO /SILENT /NOI /DELEXECUTABLE /EXETYPE:NT   $(LDFLAGS) $(RANDXMPL05_OBJECTS),$@,randxmpl05.map,,,

randxmpl05_randxmpl05.obj : .\randxmpl05.c
	$(CC) -mn -c -o$@ $(RANDXMPL05_CFLAGS) .\randxmpl05.c

