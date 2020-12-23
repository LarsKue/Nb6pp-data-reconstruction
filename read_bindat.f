      subroutine read_bindat

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




      write(*,*) 'NPAIRS: ', NPAIRS
      write(*,*) 'MODEL:  ', MODEL
      write(*,*) 'NRUN:   ', NRUN
      write(*,*) 'N:      ', N
      write(*,*) 'NC:     ', NC
      write(*,*) 'NMERGE: ', NMERGE
      write(*,*) 'AS:     ', (AS(K),K=1,30)

      end subroutine read_bindat