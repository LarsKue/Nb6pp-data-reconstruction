*       common_repair.
*       -------
*

      include 'common6.h'
      include 'repair_params.h'

      integer UNITS
      character*100 DATAPATH
      character(len=10) STEMS
      logical FORMS

*       Parameter Variables
      COMMON/RPARAMS/ DATAPATH, STEMS(NFILES), UNITS(NFILES), FORMS(NFILES)

*       Variables used for reconstruction
      COMMON/REPAIR/ BODYXZMBAR(NMAX), SEMIXRAU, RIXRBAR, VIXVSTAR,
     &      ECCS(KMAX), SEMIS(KMAX), RIS(KMAX), VIS(KMAX)



