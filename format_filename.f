      character*500 function format_filename(unit, path, stem, time)
      implicit none

*       arguments
      integer unit
      character(len=*) path
      character(len=*) stem
      integer time

*       internal variables
      character*10 int_to_str

      write(format_filename, *) trim(path), trim(stem), ".", trim(adjustl(int_to_str(unit))), "_", adjustl(int_to_str(time))

      format_filename = trim(format_filename)
      
      end function format_filename