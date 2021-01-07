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


      
      read(9, 30) NPAIRS, MODEL, NRUN, N, NC, NMERGE, (AS(K),K=1,7)
 30   format(3I4,I6,2I4,2X,F7.1,2F7.2,F7.3,F8.1,2F9.4)
      read(9,35)  (AS(K),K=8,17)
 35   format(10F11.6)
      read(9,40)  (AS(K),K=18,30)
 40   format(13F10.5)

*       skip the next line as it is titles only
      read(9,*)




C       do JPAIR = 1, NPAIRS
      do JPAIR = 1, 1

*       Missing variables
        write(*,*) 'ZMBAR:        ', ZMBAR
        write(*,*) 'SEMI:         ', SEMI
        write(*,*) 'RAU:          ', RAU
        write(*,*) 'RI:           ', RI
        write(*,*) 'RBAR:         ', RBAR
        write(*,*) 'VI:           ', VI
        write(*,*) 'VSTAR:        ', VSTAR
        write(*,*) 'H(JPAIR):     ', H(JPAIR)


        write(*,*) 'reading pair ', JPAIR
        J1 = 2*JPAIR - 1
        J2 = 2*JPAIR
        read(9,*)  NAME(J1), NAME(J2), BODY(J1),
     &         BODY(J2), EB(JPAIR), ECC(JPAIR), PB(JPAIR), 
     &         SEMIXRAU, RIXRBAR, VIXVSTAR, KSTAR(J1), KSTAR(J2),
     &         ZN, RP, STEP(J1), NAME(N+JPAIR), ECM(JPAIR), KCM


*       reconstruction? needs consult
        BODY(J1) = BODY(J1) / ZMBAR
        BODY(J2) = BODY(J2) / ZMBAR
        SEMI = -0.5*(BODY(J1) + BODY(J2))/H(JPAIR)
        RAU = SEMIXRAU / SEMI


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