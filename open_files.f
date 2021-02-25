      
      subroutine open_file(data_path, unit, stem, form, time)
      implicit none

*       arguments
      character(len=*) data_path
      integer unit
      character(len=*) stem
      character(len=*) form
      integer time

*       internal variables
      character*500 format_filename

      open(unit=unit, status='unknown', form=form, file=adjustl(format_filename(unit, data_path, stem, time)))
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

        if (INPUT(i)) then
            call open_file(INPUTPATH, UNITS(i), STEMS(i), trim(form), TREAD)
        else
            call open_file(OUTPUTPATH, UNITS(i), STEMS(i), trim(form), TREAD)
        end if

      end do

      end subroutine open_files