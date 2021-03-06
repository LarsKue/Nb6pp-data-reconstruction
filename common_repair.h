*       common_repair.
*       -------
*

      include 'common6.h'

      character*10 TSTR
      character*1 READEPOCHSTR
      character*1 WRITESEVSTR
      integer TREAD
      logical READEPOCH
      logical WRITESEV
      character*400 BDATPATH
      character*400 CONFPATH
      character*400 EPOCHPATH
      character*400 OUTPUTPATH

*       Parameter Variables
      COMMON/RPARAMS/ TSTR, READEPOCHSTR, WRITESEVSTR, TREAD, READEPOCH,
     &      WRITESEV, BDATPATH, CONFPATH, EPOCHPATH, OUTPUTPATH

*       Variables used for reconstruction
      COMMON/REPAIR/ BODYXZMBAR(NMAX), BODYIXZMBAR(NMAX),
     &      BODYJMINXZMBAR(NMAX), SEMIXRAU, RIXRBAR, VIXVSTAR,
     &      ECCS(KMAX), PBS(KMAX), SEMIS(KMAX), RIS(KMAX), VIS(KMAX), KCMS(KMAX)



