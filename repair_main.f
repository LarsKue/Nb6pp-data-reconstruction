      
      program repair_main

      character*100 data_path
      character(len=10) files(4)
      logical forms(4)
      integer units(4)
      integer i

*       initialize some parameters
      call setup()

*       initialize variables and some constants
      call zero()

*           Rainer:
*           mass = body
*           body_zero = body_mass
*           epoch = 0

*       open required files with their original handles
      call open_files(size(files), data_path, files, units, forms)

*       read in variable values from those files
      call read_files()

*       create some constants that are required to reconstruct the data
      call repair_units()

*       reconstruct variables that cannot be directly read from files
      call reconstruct()

*       reconstruct the data files
      call repair_hrplot()

*       close all files
      do i = 1, size(units)
          close(units(i))
      end do

      end program repair_main