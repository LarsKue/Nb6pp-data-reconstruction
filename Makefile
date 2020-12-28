
compiler = gfortran
# compiler flags
fcflags = -Wall -ffixed-line-length-none
# linker flags
flflags = -g -fbacktrace

# output directory
outdir = build

# include directory
idir = include

# source files
sources = $(wildcard *.[fF])

# extra source files
extra_sources = $(wildcard extra_src/*.[fF])

program = main

.PHONY: all
.DEFAULT_GOAL := all

all:
	echo $(extra_sources)
	mkdir -p $(outdir)
	$(compiler) $(fcflags) -I $(idir) -o $(outdir)/$(program) $(sources) $(extra_sources)

run:
	make all && $(outdir)/$(program)

clean:
	rm -f $(outdir)/*.o $(outdir)/*.mod