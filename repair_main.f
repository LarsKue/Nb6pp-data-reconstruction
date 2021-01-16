      
      program repair_main

      character*100 data_path
      character(len=10) files(4)
      logical forms(4)
      integer units(4)
      integer i
      integer t_read

      t_read = 160

*     these are the original files (currently only bdat.9)
C       data_path = '/media/lars/98eaa56-aba0-4d2a-9b98-32a240f0cea3/data/2020-12-16/Nbody6++GPU-Dec2019_rapidSNe/       '

*     these are copies for testing
      data_path = 'data/                                                                                               '

*       stems only, pad right with whitespace
      files(1)  = 'conf      '
*       use original unit numbers
      units(1)  = 3
*       .false. for form='unformatted' and .true. for form='formatted'
      forms(1)  = .false.


*           required:
*           metallicity = 0.00051
*           mass, metallicity, age, stellar type
*           age = time - epoch = time


      files(2)  = 'bdat      '
      units(2)  = 9
      forms(2)  = .true.

      files(3)  = 'bwdat     '
      units(3)  = 19
      forms(3)  = .true.

      files(4)  = 'merger    '
      units(4)  = 84
      forms(4)  = .true.


*       initialize variables and some constants
      call zero()

*           Rainer:
*           mass = body
*           body_zero = body_mass
*           epoch = 0

*       open required files with their original handles
      call open_files(size(files), data_path, files, units, forms, t_read)

*       read in variable values from those files
      call read_files()

*       create some constants that are required to reconstruct the data
      call repair_units()

*       reconstruct variables that cannot be directly read from files
      call reconstruct()

*       reconstruct the data here, e.g. by calling hrplot.f
C       call HRPLOT()

*       close all files
      do i = 1, size(units)
          close(units(i))
      end do

      end program repair_main