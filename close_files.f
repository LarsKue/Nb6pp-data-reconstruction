      subroutine close_files()

      include 'common_repair.h'

      close(3)
      close(9)
      close(82)

      if (WRITESEV) then
        close(83)
      end if

      if (READEPOCH) then
        close(99)
      end if

      close(100)

      end subroutine close_files