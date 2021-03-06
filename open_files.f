      
      subroutine open_file(path, unit, stem, form, time)
      implicit none

*       arguments
      character(len=*) path
      integer unit
      character(len=*) stem
      character(len=*) form
      integer time

*       internal variables
      character*500 format_filename

      open(unit=unit, status='unknown', form=form, file=adjustl(format_filename(unit, path, stem, time)))
      end subroutine open_file

      subroutine open_files()

      include 'common_repair.h'


*       input files
      call open_file(CONFPATH, 3, 'conf', 'unformatted', TREAD)
      call open_file(BDATPATH, 9, 'bdat', 'formatted', TREAD)


*       output files
      call open_file(OUTPUTPATH, 82, 'bev', 'formatted', TREAD)

      if (WRITESEV) then
        call open_file(OUTPUTPATH, 83, 'sev', 'formatted', TREAD)
      end if


*       temporary files
      if (READEPOCH) then
        call open_file(EPOCHPATH, 99, 'epochs', 'formatted', TREAD)
      end if

      call open_file(EPOCHPATH, 100, 'epochs', 'formatted', TREAD)

      end subroutine open_files