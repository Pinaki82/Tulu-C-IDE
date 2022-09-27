# =========================================================================
#     This makefile was generated by
#     Bakefile 0.2.12 (http://www.bakefile.org)
#     Do not modify, all changes will be overwritten!
# =========================================================================



# -------------------------------------------------------------------------
# These are configurable options:
# -------------------------------------------------------------------------

# C compiler 
CC = gcc

# Standard flags for CC 
CFLAGS ?= 

# Standard preprocessor flags (common for CC and CXX) 
CPPFLAGS ?= 

# Standard linker flags 
LDFLAGS ?= 



# -------------------------------------------------------------------------
# Do not modify the rest of this file!
# -------------------------------------------------------------------------

### Variables: ###

CPPDEPS = -MT$@ -MF$@.d -MD -MP
MATRIX_NXN_CFLAGS =   -Wall -Wextra -pedantic -O -O2 $(CPPFLAGS) $(CFLAGS)
MATRIX_NXN_OBJECTS =  \
	Matrix_nxn_matrix_nxn.o

### Conditionally set variables: ###



### Targets: ###

all: Matrix_nxn.exe

clean: 
	-if exist .\*.o del .\*.o
	-if exist .\*.d del .\*.d
	-if exist Matrix_nxn.exe del Matrix_nxn.exe

Matrix_nxn.exe: $(MATRIX_NXN_OBJECTS)
	$(foreach f,$(subst \,/,$(MATRIX_NXN_OBJECTS)),$(shell echo $f >> $(subst \,/,$@).rsp.tmp))
	@move /y $@.rsp.tmp $@.rsp >nul
	$(CC) -o $@ @$@.rsp   -s $(LDFLAGS)
	@-del $@.rsp

Matrix_nxn_matrix_nxn.o: ./src/matrix_nxn.c
	$(CC) -c -o $@ $(MATRIX_NXN_CFLAGS) $(CPPDEPS) $<

.PHONY: all clean


SHELL := $(COMSPEC)

# Dependencies tracking:
-include ./*.d