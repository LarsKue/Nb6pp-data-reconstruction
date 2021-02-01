      subroutine repair_hrplot

      include 'common_repair.h'

*       some variables require explicit declaration as real / integer
      REAL*8  M0,M1,M2,LUM,LUM2,MC,ME,K2

      character*100 format_filename
      integer i

      open(83, status='unknown', form='formatted', file=format_filename(83, '', 'sev', TREAD))
      open(82, status='unknown', form='formatted', file=format_filename(82, '', 'bev', TREAD))

      write(82, 1) NPAIRS, TPHYS
    1 format(I8,F9.1)

      NS = N - 2 * NPAIRS
      write(83, 1) NS, TPHYS

      IFIRST = 2 * NPAIRS + 1

*     TODO: Reconstruct these varialbes

      ZL1 = 1.0
      ZL2 = 1.0
      R1 = 1.0
      R2 = 1.0
      TE1 = 1.0
      TE2 = 1.0
      TE = 1.0

*     ---------------------------------

      do I = 1, N

        
        M1 = BODY(I) * ZMBAR

        if (I .lt. IFIRST) then

            JPAIR = KVEC(I)
            J2 = 2 * JPAIR
            J1 = 2 * JPAIR - 1

            SEMI = SEMIS(JPAIR)
            ECC = ECCS(JPAIR)

            ICM = N + JPAIR

            M2 = BODY(J2) * ZMBAR

            KW = KSTAR(J1)
            KW2 = KSTAR(J2)

            BODYI = (M1 + M2) / ZMBAR

            PB = DAYS * SEMI * sqrt(abs(SEMI) / BODYI)

*           convert into appropriate log scales etc.
            PB = log10(abs(PB))
            SEMI = log10(abs(SEMI * SU))

            write(*,*) '-----------------------------------------------'
            write(*,*) 'TTOT       = ', TTOT
            write(*,*) 'J1         = ', J1
            write(*,*) 'J2         = ', J2
            write(*,*) 'NAME(J1)   = ', NAME(J1)
            write(*,*) 'NAME(J2)   = ', NAME(J2)
            write(*,*) 'KW         = ', KW
            write(*,*) 'KW2        = ', KW2
            write(*,*) 'KSTAR(ICM) = ', KSTAR(ICM)
            write(*,*) 'RI         = ', RI
            write(*,*) 'ECC        = ', ECC
            write(*,*) 'PB         = ', PB
            write(*,*) 'SEMI       = ', SEMI
            write(*,*) 'M1         = ', M1
            write(*,*) 'M2         = ', M2
            write(*,*) 'ZL1        = ', ZL1
            write(*,*) 'ZL2        = ', ZL2
            write(*,*) 'R1         = ', R1
            write(*,*) 'R2         = ', R2
            write(*,*) 'TE1        = ', TE1
            write(*,*) 'TE2        = ', TE2
            write(*,*) '-----------------------------------------------'

            write(82, 5) TTOT, J1, J2, NAME(J1), NAME(J2), KW, KW2,
     &          KSTAR(ICM),
     &          RI, ECC, PB, SEMI, M1, M2, ZL1, ZL2, R1, R2, TE1, TE2
    5       format(1X,1P,E13.5,4I8,2I3,I4,6E13.5,6E13.5)
        else

            KW = KSTAR(I)

            write(*,*) '-----------------------------------------------'
            write(*,*) 'TTOT       = ', TTOT
            write(*,*) 'I          = ', I
            write(*,*) 'NAME(I)    = ', NAME(I)
            write(*,*) 'KW         = ', KW
            write(*,*) 'RI         = ', RI
            write(*,*) 'M1         = ', M1
            write(*,*) 'ZL1        = ', ZL1
            write(*,*) 'R1         = ', R1
            write(*,*) 'TE         = ', TE
            write(*,*) '-----------------------------------------------'

            write(83, 10) TTOT, I, NAME(I), KW, RI, M1, ZL1, R1, TE
   10       format(1X,1P,E12.5,2I8,I3,5E13.5)
        end if
      end do


      call flush(82)
      call flush(83)
      close(82)
      close(83)


*       most stars have the same age (95% born at time 0)
*       dummy value for others (created in merger, KCM < 0)

*       variable            requires                        notes
*       ZL1                 LUM                             
*       ZL2                 LUM2                            
*       LUM, LUM2           calling STAR, HRDIAG            
*       R1                  RM                              may be reproducible from bindat
*       R2                  RM2                             not found yet
*       TE1                 ZL1, R1                         
*       TE2                 ZL2, RM2                        
*       TE                  ZL1, R1                         



*       already reconstructed/available
*
*       For binaries:
*       TTOT, J1, J2, NAME(J1), NAME(J2), KW, KW2, KSTAR(ICM),
*       RI, ECC, PB, SEMI, M1, M2
*
*       For single stars:
*       TTOT, I, NAME(I), KW, RI, M1




      end subroutine repair_hrplot