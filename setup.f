      subroutine setup

      include 'common_repair.h'

*     these are the original files (currently only bdat.9)
C       DATAPATH = '/media/lars/98eaa56-aba0-4d2a-9b98-32a240f0cea3/data/2020-12-16/Nbody6++GPU-Dec2019_rapidSNe/       '

*     these are copies for testing
      DATAPATH = 'data/                                                                                               '

*       filename stems only, pad right with whitespace
      STEMS(1)  = 'conf      '
*       use original unit numbers
      UNITS(1)  = 3
*       .false. for form='unformatted' and .true. for form='formatted'
      FORMS(1)  = .false.


*           required:
*
*           metallicity = 0.00051
*           mass, metallicity, age, stellar type
*           age = time - epoch = time

      STEMS(2)  = 'bdat      '
      UNITS(2)  = 9
      FORMS(2)  = .true.

      STEMS(3)  = 'bwdat     '
      UNITS(3)  = 19
      FORMS(3)  = .true.

      STEMS(4)  = 'merger    '
      UNITS(4)  = 84
      FORMS(4)  = .true.

      end subroutine setup