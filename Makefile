
compiler = gfortran
# compiler flags
fcflags = -Wall -ffixed-line-length-none
# linker flags
flflags = -g -fbacktrace

# build directory
builddir = build/

# output directory
output = output/

# input directory
input = input/

# include directory
includedir = include/

# default for readepoch is false
readepoch = F

# source files
sources = $(wildcard *.[fF])

# extra source files
extra_sources = $(wildcard extra_src/*.[fF])

program = main

.PHONY: all build
.DEFAULT_GOAL := all

all:
	mkdir -p $(builddir)
	make build && make run

build:
	$(compiler) $(fcflags) -I $(includedir) -o $(builddir)$(program) $(sources) $(extra_sources)

run:
	$(builddir)$(program) $(time) $(input) $(output) $(readepoch)

clean:
	rm -f $(builddir)*.o $(builddir)*.mod