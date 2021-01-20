      subroutine read_files
*       this subroutine reads data that is normally written by
*       bindat.f and some others in order to allow reconstruction
*       of original variables and finally calling hrplot.F

      include 'common_repair.h'

*       Variables from bindat.f
      COMMON/POTDEN/  RHO(NMAX),XNDBL(NMAX),PHIDBL(NMAX)
      COMMON/BINARY/  CM(4,MMAX),XREL(3,MMAX),VREL(3,MMAX),
     &                HM(MMAX),UM(4,MMAX),UMDOT(4,MMAX),TMDIS(MMAX),
     &                NAMEM(MMAX),NAMEG(MMAX),KSTARM(MMAX),IFLAG(MMAX)

*       Variables from bindat.f
      REAL*8  EB(KMAX),ECC(KMAX),RCM(KMAX),ECM(KMAX),PB(KMAX),AS(30)
      REAL*8  XX(3,3),VV(3,3)
      CHARACTER*27 OUTFILE
      CHARACTER*29 OUTFILE2
      CHARACTER*20 TCHAR

*       Variables from output.F
      REAL*4  XS(3,NMAX),VS(3,NMAX),BODYS(NMAX),RHOS(NMAX),AS_OUTPUT(20)
      REAL*4  XNS(NMAX),PHI(NMAX)

*       Local Variables

      write(*,*) 'NMAX =', NMAX


*       data from conf.3 is needed to reconstruct data from bdat.9

*       Header-1
        read(3)  NTOT, MODEL, NRUN, NK

        write(*,*) 'NTOT =', NTOT

*       Header-2, N-Label
*       the AS in output.F is not the same as in bindat.f
*       so name this one differently
        read(3) (AS_OUTPUT(K),K=1,NK),
     &      (BODYS(J),J=1,NTOT), (RHOS(J),J=1,NTOT), (XNS(J),J=1,NTOT),
     &      ((XS(K,J),K=1,3),J=1,NTOT), ((VS(K,J),K=1,3),J=1,NTOT),
     &      (PHI(J),J=1,NTOT), (NAME(J),J=1,NTOT)


*       Are these the same as used in bdat? the manual suggests they are
*       but this may need explicit code confirmation
        RBAR = AS_OUTPUT(3)
        ZMBAR = AS_OUTPUT(4)
        VSTAR = AS_OUTPUT(12)

        write(*,*) 'Verify:'
        write(*,*) 'RBAR:  ', RBAR
        write(*,*) 'ZMBAR: ', ZMBAR
        write(*,*) 'VSTAR: ', VSTAR
        write(*,*) '==================================================='


*       Header-1
      read(9, 30) NPAIRS, MODEL, NRUN, N, NC, NMERGE, (AS(K),K=1,7)
 30   format(3I4,I6,2I4,2X,F7.1,2F7.2,F7.3,F8.1,2F9.4)

*       Header-2
      read(9,35)  (AS(K),K=8,17)
 35   format(10F11.6)

*       Header-3
      read(9,40)  (AS(K),K=18,30)
 40   format(13F10.5)

*       skip the next line as it is titles only
      read(9,*)


*       H-Label-4, core data, consisting of
*       NAME(I1), NAME(I2), M1[M*], M2[M*], E[NB], ECC, P[days],
*       SEMI[AU], RI[PC], VI[km/s], K*(I1), K*(I2), ZN[NB], RP[NB],
*       STEP(I1)[NB], NAME(ICM), ECM[NB], K*(ICM)

      do JPAIR = 1, NPAIRS
C       do JPAIR = 1, 5

        write(*,*) 'reading pair ', JPAIR

        J1 = 2*JPAIR - 1
        J2 = 2*JPAIR

        read(9,*)  NAME(J1), NAME(J2), BODYXZMBAR(J1),
     &         BODYXZMBAR(J2), EB(JPAIR), ECC(JPAIR), PB(JPAIR), 
     &         SEMIXRAU, RIXRBAR, VIXVSTAR, KSTAR(J1), KSTAR(J2),
     &         ZN, RP, STEP(J1), NAME(N+JPAIR), ECM(JPAIR), KCM


*       Verify
        write(*,*) 'Verify:         '
        write(*,*) 'NAME(J1):       ', NAME(J1)
        write(*,*) 'NAME(J2):       ', NAME(J2)
        write(*,*) 'BODYXZMBAR(J1): ', BODYXZMBAR(J1)
        write(*,*) 'BODYXZMBAR(J2): ', BODYXZMBAR(J2)
        write(*,*) 'EB(JPAIR):      ', EB(JPAIR)
        write(*,*) 'ECC(JPAIR):     ', ECC(JPAIR)
        write(*,*) 'PB(JPAIR):      ', PB(JPAIR)
        write(*,*) 'SEMI*RAU:       ', SEMIXRAU
        write(*,*) 'RI*RBAR:        ', RIXRBAR
        write(*,*) 'VI*VSTAR:       ', VIXVSTAR
        write(*,*) 'KSTAR(J1):      ', KSTAR(J1)
        write(*,*) 'KSTAR(J2):      ', KSTAR(J2)
        write(*,*) 'ZN:             ', ZN
        write(*,*) 'RP:             ', RP
        write(*,*) 'STEP(J1):       ', STEP(J1)
        write(*,*) 'NAME(N+JPAIR):  ', NAME(N+JPAIR)
        write(*,*) 'ECM(JPAIR):     ', ECM(JPAIR)
        write(*,*) 'KCM:            ', KCM
        write(*,*) '==================================================='


      end do


*       print some of the variables to validate they were read correctly
      write(*,*) 'NPAIRS: ', NPAIRS
      write(*,*) 'MODEL:  ', MODEL
      write(*,*) 'NRUN:   ', NRUN
      write(*,*) 'N:      ', N
      write(*,*) 'NC:     ', NC
      write(*,*) 'NMERGE: ', NMERGE
      write(*,*) 'AS:     ', (AS(K),K=1,30)

      end subroutine read_files