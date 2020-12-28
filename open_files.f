      
      character*10 function int_to_str(i)
      implicit none
      integer i
*       32-bit integers can at most have 10 digits
      write(int_to_str, "(I10)") i
      end function int_to_str


      character*100 function format_filename(unit, data_path, stem, time)
      implicit none
      integer unit
      character(len=*) data_path
      character(len=*) stem
      integer time
      character*10 int_to_str

      write(format_filename, *) trim(data_path), trim(stem), ".", trim(adjustl(int_to_str(unit))), "_", adjustl(int_to_str(time))

      format_filename = trim(format_filename)
      
      end function format_filename


      subroutine open_file(data_path, unit, stem, time)
      implicit none
      character(len=*) data_path
      integer unit
      character(len=*) stem
      integer time
      character*100 format_filename

      open(unit=unit, status='old', form='formatted', file=adjustl(format_filename(unit, data_path, stem, time)))
      end subroutine open_file

      subroutine open_files(n_files, data_path, stems, units, time)
      implicit none
      integer n_files
      character(len=*) data_path
      character(len=*) stems(*)
      integer units(*)
      integer time
      integer i

      do i = 1, n_files

        call open_file(data_path, units(i), stems(i), time)

      end do

      end subroutine open_files