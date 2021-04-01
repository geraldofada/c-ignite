# Author: Geraldo Fada (github.com/geraldofada)
# License: MIT

# Folders
SRC = src
OBJ = obj
BIN = bin
DEBUG = debug
RELEASE = release

DOBJ = $(OBJ)/$(DEBUG)
ROBJ = $(OBJ)/$(RELEASE)
DBIN = $(BIN)/$(DEBUG)
RBIN = $(BIN)/$(RELEASE)

# Files
SRCS = $(wildcard $(SRC)/*.c)

DOBJS = $(patsubst $(SRC)/%.c, $(DOBJ)/%.o, $(SRCS))
ROBJS = $(patsubst $(SRC)/%.c, $(ROBJ)/%.o, $(SRCS))

# Executable
EXE = main

DEXE = $(DBIN)/$(EXE)
REXE = $(RBIN)/$(EXE)

# Compiler related
CC = clang
CFLAGS = -Wall

DCFLAGS = $(CFLAGS) -O0 -DDEBUG -g
RCFLAGS = $(CFLAGS) -O3 -DNDEBUG

# Rules
all: debug

# Debug
debug: $(DEXE)

$(DEXE): $(DOBJS)
	$(CC) $(DCFLAGS) $(DOBJS) -o $@

$(DOBJ)/%.o: $(SRC)/%.c
	$(CC) $(DCFLAGS) -c $< -o $@

rund:
	-@./$(DEXE)

# Release
release: $(REXE)

$(REXE): $(ROBJS)
	$(CC) $(RCFLAGS) $(ROBJS) -o $@

$(ROBJ)/%.o: $(SRC)/%.c
	$(CC) $(RCFLAGS) -c $< -o $@

runr:
	-@./$(REXE)

# Helpers
clean:
	rm -rf $(DOBJ)/* $(DBIN)/*
	rm -rf $(ROBJ)/* $(RBIN)/*

remake: clean all

prep:
	mkdir -p $(DOBJ) $(ROBJ) $(DBIN) $(RBIN) $(SRC)
