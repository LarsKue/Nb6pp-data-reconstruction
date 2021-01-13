      
      character*10 function int_to_str(i)
      implicit none
      integer i
*       32-bit integers can at most have 10 digits
      write(int_to_str, "(I10)") i
      end function int_to_str


      character*100 function format_filename(unit, data_path, stem, time)
      implicit none

*       arguments
      integer unit
      character(len=*) data_path
      character(len=*) stem
      integer time

*       internal variables
      character*10 int_to_str

      write(format_filename, *) trim(data_path), trim(stem), ".", trim(adjustl(int_to_str(unit))), "_", adjustl(int_to_str(time))

      format_filename = trim(format_filename)
      
      end function format_filename

      subroutine open_file(data_path, unit, stem, form, time)
      implicit none

*       arguments
      character(len=*) data_path
      integer unit
      character(len=*) stem
      character(len=*) form
      integer time

*       internal variables
      character*100 format_filename

      open(unit=unit, status='old', form=form, file=adjustl(format_filename(unit, data_path, stem, time)))
      end subroutine open_file

      subroutine open_files(n_files, data_path, stems, units, forms, time)
      implicit none

*       arguments
      integer n_files
      character(len=*) data_path
      character(len=*) stems(*)
      integer units(*)
      logical forms(*)

*       internal variables
      character(len=11) form
      integer time
      integer i


      do i = 1, n_files

        if (forms(i)) then
            form = 'formatted  '
        else
            form = 'unformatted'
        end if

        call open_file(data_path, units(i), stems(i), trim(form), time)

      end do

      end subroutine open_files