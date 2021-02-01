      
      character*10 function int_to_str(i)
      implicit none
      integer i
*       32-bit integers can at most have 10 digits
      write(int_to_str, "(I10)") i
      end function int_to_str

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

      subroutine open_files()

      include 'common_repair.h'

      character(len=11) form
      integer i

      do i = 1, NFILES

        if (FORMS(i)) then
            form = 'formatted  '
        else
            form = 'unformatted'
        end if

        call open_file(DATAPATH, UNITS(i), STEMS(i), trim(form), TREAD)

      end do

      end subroutine open_files