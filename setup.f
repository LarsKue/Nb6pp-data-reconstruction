      subroutine setup

      include 'common_repair.h'

*     pass read time and input/output paths as command line argument
      call getarg(1, TSTR)
      call getarg(2, BDATPATH)
      call getarg(3, CONFPATH)
      call getarg(4, EPOCHPATH)
      call getarg(5, OUTPUTPATH)

*     also pass if epochs should be read as command line argument
      call getarg(6, READEPOCHSTR)
      
      call getarg(7, WRITESEVSTR)

*     convert time to integer / logical
      read(TSTR, *) TREAD
      read(READEPOCHSTR, *) READEPOCH
      read(WRITESEVSTR, *) WRITESEV
      

      end subroutine setup