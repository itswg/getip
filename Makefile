CC=g++
CFLAGS= -Wall -g -I /opt/local/include/ -I./shared/src -I./ -fpic
LIBDIR=
OBJECTDIR=objects
LDFLAGS= -L./$(LIBDIR)
BIN=getip
EXECUTABLES= $(BIN)
LIBRARY=
TCL_INTERFACE_LIBRARY=libGetiptcl.so

OBJECTS_= \
 	getip_code.o \
 	getip.o

OBJECTS = $(patsubst %,$(OBJECTDIR)/%,$(OBJECTS_))
LIBOBJECTS = $(patsubst %,$(LIBDIR)/$(OBJECTDIR)/%,$(LIBOBJECTS_))

chkmkdir = $(if $(wildcard $1),,mkdir -p $1)

all: $(TCL_INTERFACE_LIBRARY) $(EXECUTABLES)

$(EXECUTABLES): $(LIBRARY)

$(OBJECTDIR)/%.o: %.C
	$(call chkmkdir, $(dir $@))
	$(CC) $(CFLAGS) $(LDFLAGS) -c $< -o $@

#-----------------------------------------------------------------------------

$(BIN): $(OBJECTS) $(OBJECTDIR)/$(BIN).o
	$(call chkmkdir, $(dir $@))
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJECTS) -o $@

$(TCL_INTERFACE_LIBRARY): $(LIBRARY) $(OBJECTDIR)/TclInterface.o $(OBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) -ltcl8.5 -shared \
	  $(OBJECTDIR)/TclInterface.o $(OBJECTDIR)/getip_code.o -o $@


remake: clean
	make

clean:
	rm -f $(EXECUTABLES) $(OBJECTDIR)/*.o
	rm -fr $(OBJECTDIR)

install: all
	@echo ; echo Warning: Can compile, but install implemented yet.
