      subroutine setup

      include 'common_repair.h'

*     these are the original files (currently only bdat.9)
C       DATAPATH = '/media/lars/98eaa56-aba0-4d2a-9b98-32a240f0cea3/data/2020-12-16/Nbody6++GPU-Dec2019_rapidSNe/       '                                                                                           '

*       filename stems only, pad right with whitespace
      STEMS(1)  = 'conf      '
*       use original unit numbers
      UNITS(1)  = 3
*       .false. for form='unformatted' and .true. for form='formatted'
      FORMS(1)  = .false.
*       .true. for input files and .false. for output files
      INPUT(1)  = .true.


      STEMS(2)  = 'bdat      '
      UNITS(2)  = 9
      FORMS(2)  = .true.
      INPUT(2)  = .true.


*     Output files
      STEMS(3) = 'bev        '
      UNITS(3) = 82
      FORMS(3) = .true.
      INPUT(3) = .false.

      STEMS(4) = 'sev        '
      UNITS(4) = 83
      FORMS(4) = .true.
      INPUT(4) = .false.


*     Files to set and read EPOCH
      STEMS(5) = 'epochs     '
      UNITS(5) = 99
      FORMS(5) = .true.
      INPUT(5) = .true.

      STEMS(6) = 'epochs     '
      UNITS(6) = 100
      FORMS(6) = .true.
      INPUT(6) = .false.


*     pass read time and input/output path as command line argument
      call getarg(1, TSTR)
      call getarg(2, INPUTPATH)
      call getarg(3, OUTPUTPATH)

*     also pass if epochs should be read as command line argument
      call getarg(4, READEPOCHSTR)

*     convert time to integer / logical
      read(TSTR, *) TREAD
      read(READEPOCHSTR, *) READEPOCH
      

      end subroutine setup