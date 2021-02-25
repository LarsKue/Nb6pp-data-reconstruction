*       common_repair.
*       -------
*

      include 'common6.h'
      include 'repair_params.h'

      character*10 TSTR
      character*1 READEPOCHSTR
      integer TREAD
      logical READEPOCH
      integer UNITS
      character*400 INPUTPATH
      character*400 OUTPUTPATH
      character(len=10) STEMS
      logical FORMS
      logical INPUT

*       Parameter Variables
      COMMON/RPARAMS/ TSTR, READEPOCHSTR, TREAD, READEPOCH, INPUTPATH,
     &      OUTPUTPATH,
     &      STEMS(NFILES), UNITS(NFILES), FORMS(NFILES), INPUT(NFILES)

*       Variables used for reconstruction
      COMMON/REPAIR/ BODYXZMBAR(NMAX), BODYIXZMBAR(NMAX),
     &      BODYJMINXZMBAR(NMAX), SEMIXRAU, RIXRBAR, VIXVSTAR,
     &      ECCS(KMAX), PBS(KMAX), SEMIS(KMAX), RIS(KMAX), VIS(KMAX), KCMS(KMAX)



