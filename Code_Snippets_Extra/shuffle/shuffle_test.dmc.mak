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

SHUFFLE_TEST_CFLAGS =    -W- -A -H -s -o -O $(CPPFLAGS) $(CFLAGS)
SHUFFLE_TEST_OBJECTS =  \
	shuffle_test_shuffle_test.obj

### Targets: ###

all : shuffle_test.exe

clean : 
	-if exist .\*.obj del .\*.obj
	-if exist .\*.res del .\*.res
	-if exist .\*.sym del .\*.sym
	-if exist shuffle_test.exe del shuffle_test.exe
	-if exist shuffle_test.map del shuffle_test.map

shuffle_test.exe : $(SHUFFLE_TEST_OBJECTS)  shuffle_test_resource.res
	link /NOLOGO /SILENT /NOI /DELEXECUTABLE /EXETYPE:NT   $(LDFLAGS) $(SHUFFLE_TEST_OBJECTS),$@,shuffle_test.map,,, shuffle_test_resource.res

shuffle_test_resource.res : .\resource.rc
	rcc .\resource.rc -o$@  -32 -v-

shuffle_test_shuffle_test.obj : .\shuffle_test.c
	$(CC) -mn -c -o$@ $(SHUFFLE_TEST_CFLAGS) .\shuffle_test.c

