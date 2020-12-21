      
      character*10 function int_to_str(i)
      implicit none
      integer i
      write(int_to_str, "(I10)") i
      end function int_to_str


      character*100 function format_filename(unit, data_path, stem)
      implicit none
      integer unit
      character(len=*) data_path
      character(len=*) stem
      character*10 int_to_str

      write(format_filename, *) trim(data_path), trim(stem), ".", adjustl(int_to_str(unit))

      format_filename = trim(format_filename)
      
      end function format_filename


      subroutine open_file(unit, data_path, stem)
      implicit none
      integer unit
      character(len=*) data_path
      character(len=*) stem
      character*100 format_filename

      open(unit=unit, status='old', form='formatted',
     &     file=adjustl(format_filename(unit, data_path, stem)))
      end subroutine open_file

      program repair_main

      character*10 data_path
      character*10 files(3)
      integer units(3)
      integer i

      data_path = 'data/     '

*       stems only
      files(1) =  'bdat      '
      units(1) = 9
      files(2) =  'bwdat     '
      units(2) = 19
      files(3) =  'merger    '
      units(3) = 84

*       open required files with their original handles
      do i = 1, size(units)
          call open_file(units(i), data_path, files(i))
      end do

      call BINDAT

C       call READ_BINDAT


*       close all files
      do i = 1, size(units)
          close(units(i))
      end do

      contains
C       include 'read_bindat.f'
      include 'findj.f'
      include 'inclin.f'
      include 'stability.f'
      include 'xtrnlv.F'
      include 'string_left.f'
      include 'bindat.f'

      end program repair_main