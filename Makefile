CC=g++
CFLAGS= -Wall -g -I /opt/local/include/ -I./shared/src -I./ -fpic -std=c++0x
LIBDIR=
OBJECTDIR=objects
LDFLAGS= -L./$(LIBDIR)
BIN=getip
PREFIX=/usr/local
ifneq ("$(prefix)","")
	PREFIX=$(prefix)
endif

BINDIR=$(PREFIX)/bin
LIBDIR=$(PREFIX)/lib
EXECUTABLES= $(BIN)
LIBRARY=
TCL_INTERFACE_LIBRARY=libgetiptcl.so

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
	install -d -m 0755 $(BINDIR)/;
	install -d -m 0755 $(LIBDIR)/
	install -m 0755 $(BIN) $(BINDIR)/;
	install -m 0755 $(TCL_INTERFACE_LIBRARY) $(LIBDIR)/
