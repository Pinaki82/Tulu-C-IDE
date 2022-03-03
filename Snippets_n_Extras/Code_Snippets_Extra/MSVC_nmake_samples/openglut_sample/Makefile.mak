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

TESTINGAPP_CFLAGS = /MD /DWIN32 /D_WINDOWS /D_OPENGLUT_STATIC /IC:\xtralibs\appu \
	/IC:\xtralibs\OpenGLUT-0.6.3vc /TC /W4 $(CPPFLAGS) $(CFLAGS)
TESTINGAPP_OBJECTS =  \
	testingapp_openglut.obj
TESTINGAPP_RESOURCES =  \
	testingapp_resource.res

### Conditionally set variables: ###



### Targets: ###

all: testingapp.exe

clean: 
	-if exist .\*.obj del .\*.obj
	-if exist .\*.res del .\*.res
	-if exist .\*.pch del .\*.pch
	-if exist testingapp.exe del testingapp.exe
	-if exist testingapp.ilk del testingapp.ilk
	-if exist testingapp.pdb del testingapp.pdb

testingapp.exe: $(TESTINGAPP_OBJECTS) testingapp_resource.res
	link /NOLOGO /OUT:$@  /SUBSYSTEM:WINDOWS /LIBPATH:C:\xtralibs\OpenGLUT-0.6.3vc /ENTRY:"mainCRTStartup" $(LDFLAGS) @<<
	$(TESTINGAPP_OBJECTS) $(TESTINGAPP_RESOURCES)  user32.lib kernel32.lib shell32.lib gdi32.lib comctl32.lib ole32.lib OpenGLUT_static.lib OpenGLUT.lib glu32.lib opengl32.lib winmm.lib OpenGLUT.lib
<<

testingapp_resource.res: .\resource.rc
	rc /fo$@  /d WIN32 /d _WINDOWS /d _OPENGLUT_STATIC /i C:\xtralibs\appu /i C:\xtralibs\OpenGLUT-0.6.3vc .\resource.rc

testingapp_openglut.obj: .\openglut.c
	$(CC) /c /nologo /TC /Fo$@ $(TESTINGAPP_CFLAGS) .\openglut.c
