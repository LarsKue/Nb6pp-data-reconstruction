      
      program repair_main

      character*100 data_path
      character(len=10) files(3)
      integer units(3)
      integer i
      integer t_read

      t_read = 160

*     these are the original files
C       data_path = '/media/lars/98eaa56-aba0-4d2a-9b98-32a240f0cea3/data/2020-12-16/Nbody6++GPU-Dec2019_rapidSNe/       '

*     these are copies for testing
      data_path = 'data/                                                                                               '

*       stems only, pad with whitespace
      files(1) =  'bdat      '
      units(1) = 9
      files(2) =  'bwdat     '
      units(2) = 19
      files(3) =  'merger    '
      units(3) = 84

*       initialize variables
      call zero()

*           Rainer:
*           mass = body
*           body_zero = body_mass
*           epoch = 0

*       open required files with their original handles
      call open_files(size(files), data_path, files, units, t_read)

*       read in variable values from those files
      call read_bindat()

*       reconstruct the data here, e.g. by calling bindat.f or hrplot.f
C       call BINDAT()
C       call HRPLOT()

*       close all files
      do i = 1, size(units)
          close(units(i))
      end do

      end program repair_main