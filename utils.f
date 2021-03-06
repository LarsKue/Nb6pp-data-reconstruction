      character*10 function int_to_str(i)
      implicit none
      integer i
*       32-bit integers can at most have 10 digits
      write(int_to_str, "(I10)") i
      end function int_to_str


      integer function str_to_int(s)
      implicit none
      character(len=*) s
      integer stat
      read(s, *, iostat=stat) str_to_int
      end function str_to_int