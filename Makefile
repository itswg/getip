CC=g++
CFLAGS= -Wall -g -I /opt/local/include/ -I./shared/src -I./
LIBDIR=
OBJECTDIR=objects
LDFLAGS= -L./$(LIBDIR)
BIN=getip
EXECUTABLES= $(BIN)
LIBRARY=

OBJECTS_= \
 	getip.o

OBJECTS = $(patsubst %,$(OBJECTDIR)/%,$(OBJECTS_))
LIBOBJECTS = $(patsubst %,$(LIBDIR)/$(OBJECTDIR)/%,$(LIBOBJECTS_))

chkmkdir = $(if $(wildcard $1),,mkdir -p $1)

all: $(LIBRARY) $(EXECUTABLES)

$(EXECUTABLES): $(LIBRARY)

$(OBJECTDIR)/%.o: %.C
	$(call chkmkdir, $(dir $@))
	$(CC) $(CFLAGS) $(LDFLAGS) -c $< -o $@

#-----------------------------------------------------------------------------

$(BIN): $(OBJECTDIR)/$(BIN).o
	$(call chkmkdir, $(dir $@))
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJECTDIR)/$(BIN).o -o $@


remake: clean
	make

clean:
	rm -f $(EXECUTABLES) $(OBJECTDIR)/*.o
	rm -fr $(OBJECTDIR)

install: all
	@echo ; echo Warning: Can compile, but install implemented yet.
