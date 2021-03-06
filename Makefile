
compiler = gfortran
# compiler flags
fcflags = -Wall -ffixed-line-length-none
# linker flags
flflags = -g -fbacktrace

# build directory
builddir = build/

# output directory
output = output/

# input directories
bdat = input/
conf = input/
epoch = input/

# include directory
includedir = include/

# default for readepoch is false
readepoch = F

# default for writesev is false
writesev = F

# source files
sources = $(wildcard *.[fF])

# extra source files
extra_sources = $(wildcard extra_src/*.[fF])

program = main

.PHONY: all build
.DEFAULT_GOAL := all

all:
	make build && make run

build:
	mkdir -p $(builddir)
	$(compiler) $(fcflags) -I $(includedir) -o $(builddir)$(program) $(sources) $(extra_sources)

run:
	$(builddir)$(program) $(time) $(bdat) $(conf) $(epoch) $(output) $(readepoch) $(writesev)

clean:
	rm -f $(builddir)*.o $(builddir)*.mod