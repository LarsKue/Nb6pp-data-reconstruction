
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
sources = $(wildcard *.f)

program = main

.PHONY: all
.DEFAULT_GOAL := all

all:
	mkdir -p $(outdir)
	$(compiler) $(fcflags) -I $(idir) -o $(outdir)/$(program) $(sources)

run:
	make all && $(outdir)/$(program)

clean:
	rm -f $(outdir)/*.o $(outdir)/*.mod