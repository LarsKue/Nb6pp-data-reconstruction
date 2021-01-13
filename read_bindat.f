      subroutine read_bindat
*       this subroutine reads all data that bindat.f normally writes

      include 'common6.h'

      COMMON/POTDEN/  RHO(NMAX),XNDBL(NMAX),PHIDBL(NMAX)
      COMMON/BINARY/  CM(4,MMAX),XREL(3,MMAX),VREL(3,MMAX),
     &                HM(MMAX),UM(4,MMAX),UMDOT(4,MMAX),TMDIS(MMAX),
     &                NAMEM(MMAX),NAMEG(MMAX),KSTARM(MMAX),IFLAG(MMAX)
      REAL*8  EB(KMAX),ECC(KMAX),RCM(KMAX),ECM(KMAX),PB(KMAX),AS(30)
      REAL*8  XX(3,3),VV(3,3)
      CHARACTER*27 OUTFILE
      CHARACTER*29 OUTFILE2
      CHARACTER*20 TCHAR

      REAL*4  XS(3,NMAX),VS(3,NMAX),BODYS(NMAX),RHOS(NMAX),AS_OUTPUT(20)
      REAL*4  XNS(NMAX),PHI(NMAX)


*       data from conf.3 may be needed to reconstruct data from bdat.9

*       Header-1
        read(3)  NTOT, MODEL, NRUN, NK

*       this works fine
        write(*,*) 'NTOT:  ', NTOT
        write(*,*) 'MODEL: ', MODEL
        write(*,*) 'NRUN:  ', NRUN
        write(*,*) 'NK:    ', NK

*       Header-2
*       the AS in output.F is not the same as in bindat.f
*       so name this one differently
        read(3) (AS_OUTPUT(K),K=1,NK)

*       N-Label
*       what is NAME?
        read(3) (BODYS(J),J=1,NTOT), (RHOS(J),J=1,NTOT), (XNS(J),J=1,NTOT),
     &      ((XS(K,J),K=1,3),J=1,NTOT), ((VS(K,J),K=1,3),J=1,NTOT),
     &      (PHI(J),J=1,NTOT), (NAME(J),J=1,NTOT)

*       Are these the same as used in bdat? the manual suggests they are
*       but this may need explicit code confirmation
        RBAR = AS_OUTPUT(3)
        ZMBAR = AS_OUTPUT(4)
        VSTAR = AS_OUTPUT(12)


        write(*,*) 'AS_OUTPUT:', AS_OUTPUT




*       Missing Variables
        RAU = 1.0



        


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

C       do JPAIR = 1, NPAIRS
      do JPAIR = 1, 1

        write(*,*) 'reading pair ', JPAIR

        J1 = 2*JPAIR - 1
        J2 = 2*JPAIR

        read(9,*)  NAME(J1), NAME(J2), BODY1XZMBAR,
     &         BODY2XZMBAR, EB(JPAIR), ECC(JPAIR), PB(JPAIR), 
     &         SEMIXRAU, RIXRBAR, VIXVSTAR, KSTAR(J1), KSTAR(J2),
     &         ZN, RP, STEP(J1), NAME(N+JPAIR), ECM(JPAIR), KCM



*       Reconstruction
        BODY(J1) = BODY1XZMBAR / ZMBAR
        BODY(J2) = BODY2XZMBAR / ZMBAR
        RI = RIXRBAR / RBAR
        VI = VIXVSTAR / VSTAR



*       TODO
*       either this
        SEMI = SEMIXRAU / RAU
*       or this
        SEMI = -0.5*(BODY(J1) + BODY(J2)) / H(JPAIR)
        RAU = SEMIXRAU / SEMI







*       Verify
        write(*,*) 'NAME(J1):       ', NAME(J1)
        write(*,*) 'NAME(J2):       ', NAME(J2)
        write(*,*) 'BODY(J1):       ', BODY(J1)
        write(*,*) 'BODY(J2):       ', BODY(J2)
        write(*,*) 'EB(JPAIR):      ', EB(JPAIR)
        write(*,*) 'ECC(JPAIR):     ', ECC(JPAIR)
        write(*,*) 'PB(JPAIR):      ', PB(JPAIR)
        write(*,*) 'SEMI*RAU:       ', SEMIXRAU
        write(*,*) 'SEMI:           ', SEMI
        write(*,*) 'RAU:            ', RAU
        write(*,*) 'RI*RBAR:        ', RIXRBAR
        write(*,*) 'RI:             ', RI
        write(*,*) 'RBAR:           ', RBAR
        write(*,*) 'VI*VSTAR:       ', VIXVSTAR
        write(*,*) 'VI:             ', VI
        write(*,*) 'VSTAR:          ', VSTAR
        write(*,*) 'KSTAR(J1):      ', KSTAR(J1)
        write(*,*) 'KSTAR(J2):      ', KSTAR(J2)
        write(*,*) 'ZN:             ', ZN
        write(*,*) 'RP:             ', RP
        write(*,*) 'STEP(J1):       ', STEP(J1)
        write(*,*) 'NAME(N+JPAIR):  ', NAME(N+JPAIR)
        write(*,*) 'ECM(JPAIR):     ', ECM(JPAIR)
        write(*,*) 'KCM:            ', KCM


      end do


*       print some of the variables to validate they were read correctly
      write(*,*) 'NPAIRS: ', NPAIRS
      write(*,*) 'MODEL:  ', MODEL
      write(*,*) 'NRUN:   ', NRUN
      write(*,*) 'N:      ', N
      write(*,*) 'NC:     ', NC
      write(*,*) 'NMERGE: ', NMERGE
      write(*,*) 'AS:     ', (AS(K),K=1,30)

      end subroutine read_bindat