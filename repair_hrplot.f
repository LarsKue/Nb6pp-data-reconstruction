      subroutine repair_hrplot

      include 'common_repair.h'

*       some variables require explicit declaration as real / integer
      REAL*8  M0,M1,M2,LUM,LUM2,MC,ME,K2

*       arrays that are not part of common6.h
      real*8 tscls(20),lums(10),GB(10)

      real*8 AGE1, AGE2

*       local variables
      integer I



      write(82, 1) NPAIRS, TPHYS
    1 format(I8,F9.1)

      NS = N - 2 * NPAIRS
      write(83, 1) NS, TPHYS

      IFIRST = 2 * NPAIRS + 1

*       We are only reconstructing stars that did not collide
      AGE = TTOT * TSTAR

*       Metallicity
      ZMET = 0.0005

*       initialize zpars
      call zcnsts(ZMET, ZPARS)

      do 20 I = 1, N
        if (I .lt. IFIRST) then
            JPAIR = KVEC(I)
            J2 = 2 * JPAIR
            if (I .eq. J2) then
                goto 20
            end if
            J1 = 2 * JPAIR - 1
            ICM = N + JPAIR

            KW = KSTAR(J1)

*           adjust EPOCH and AGE for remnants
            if ((KW .ge. 10) .and. (KW .le. 14)) then
              if (abs(EPOCH(J1)) .lt. 1d-14) then
C                 do not overwrite existing nonzero EPOCH
                EPOCH(J1) = AGE
              end if
            end if

            AGE1 = AGE - EPOCH(J1)

            M1 = BODYXZMBAR(J1)
            M0 = M1

*       call STAR and HRDIAG to initialize luminosities, radii and temperatures
            CALL STAR(KW,M0,M1,TM,TN,TSCLS,LUMS,GB,ZPARS)
            CALL HRDIAG(M0,AGE1,M1,TM,TN,TSCLS,LUMS,GB,ZPARS,RM,LUM,KW,MC,RCC,ME,RE,K2)


            M2 = BODYXZMBAR(J2)
            M0 = M2
            KW2 = KSTAR(J2)

*           adjust EPOCH and AGE for remnants
            if ((KW2 .ge. 10) .and. (KW2 .le. 14)) then
              if (abs(EPOCH(J2)) .lt. 1d-14) then
C                 do not overwrite existing nonzero EPOCH
                EPOCH(J2) = AGE
              end if
            end if

            AGE2 = AGE - EPOCH(J2)

*           Specify relevant binary mass (we do not reconstruct ghosts)
            BODYI = (M1 + M2) / ZMBAR

*           We can read these from bdat instead of recalculating
            SEMI = SEMIS(JPAIR)
            ECC = ECCS(JPAIR)

*           We cannot reconstruct binaries which gained mass (KCM > 0)
            KCM = KCMS(JPAIR)
            if (KCM .gt. 0) then
                goto 20
            end if

            RI = RIS(JPAIR)
            PB = PBS(JPAIR)

*           this is where the original bug occurred (KW instead of KW2 in HRDIAG)
            CALL STAR(KW2,M0,M2,TM,TN,TSCLS,LUMS,GB,ZPARS)
            CALL HRDIAG(M0,AGE,M2,TM,TN,TSCLS,LUMS,GB,ZPARS,RM2,LUM2,KW2,MC,RCC,ME,RE,K2)

*           convert into appropriate log scales etc.
            PB = log10(abs(PB))
            SEMI = log10(abs(SEMI * SU))
            R1 = log10(RM)
            R2 = log10(RM2)
            ZL1 = log10(LUM)
            ZL2 = log10(LUM2)
            TE1 = 0.25 * (ZL1 - 2.0 * R1) + 3.761777537508
            TE2 = 0.25 * (ZL2 - 2.0 * R2) + 3.761777537508

C             write(*,*) 'I          = ', I
C             write(*,*) 'JPAIR      = ', JPAIR
C             write(*,*) '-----------------------------------------------'
C             write(*,*) 'TTOT       = ', TTOT
C             write(*,*) 'J1         = ', J1
C             write(*,*) 'J2         = ', J2
C             write(*,*) 'NAME(J1)   = ', NAME(J1)
C             write(*,*) 'NAME(J2)   = ', NAME(J2)
C             write(*,*) 'KW         = ', KW
C             write(*,*) 'KW2        = ', KW2
C             write(*,*) 'KSTAR(ICM) = ', KSTAR(ICM)
C             write(*,*) 'RI         = ', RI
C             write(*,*) 'ECC        = ', ECC
C             write(*,*) 'PB         = ', PB
C             write(*,*) 'SEMI       = ', SEMI
C             write(*,*) 'M1         = ', M1
C             write(*,*) 'M2         = ', M2
C             write(*,*) 'ZL1        = ', ZL1
C             write(*,*) 'ZL2        = ', ZL2
C             write(*,*) 'R1         = ', R1
C             write(*,*) 'R2         = ', R2
C             write(*,*) 'TE1        = ', TE1
C             write(*,*) 'TE2        = ', TE2
C             write(*,*) '-----------------------------------------------'

            write(82, 5) TTOT, J1, J2, NAME(J1), NAME(J2), KW, KW2,
     &          KSTAR(ICM),
     &          RI, ECC, PB, SEMI, M1, M2, ZL1, ZL2, R1, R2, TE1, TE2
    5       format(1X,1P,E13.5,4I8,2I3,I4,6E13.5,6E13.5)


            write(100,*) EPOCH(J1), EPOCH(J2)
        else

            M1 = BODY(I) * ZMBAR
            M0 = M1

*           obtain stellar parameters at current epoch
            KW = KSTAR(I)

*           call STAR and HRDIAG to initialize luminosities, radii and temperatures
            CALL STAR(KW,M0,M1,TM,TN,TSCLS,LUMS,GB,ZPARS)
            CALL HRDIAG(M0,AGE,M1,TM,TN,TSCLS,LUMS,GB,ZPARS,RM,LUM,KW,MC,RCC,ME,RE,K2)
            

C             write(*,*) '-----------------------------------------------'
C             write(*,*) 'TTOT       = ', TTOT
C             write(*,*) 'I          = ', I
C             write(*,*) 'NAME(I)    = ', NAME(I)
C             write(*,*) 'KW         = ', KW
C             write(*,*) 'RI         = ', RI
C             write(*,*) 'M1         = ', M1
C             write(*,*) 'ZL1        = ', ZL1
C             write(*,*) 'R1         = ', R1
C             write(*,*) 'TE         = ', TE
C             write(*,*) '-----------------------------------------------'


*           Note: this data is incomplete because we have the
*           correct data anyway, but it would not be hard to reproduce
*           this too
*           Example: RI is not properly initialized for Singular Stars
            write(83, 10) TTOT, I, NAME(I), KW, RI, M1, ZL1, R1, TE
   10       format(1X,1P,E12.5,2I8,I3,5E13.5)
        end if
   20 end do


      call flush(82)
      call flush(83)
      close(82)
      close(83)

      end subroutine repair_hrplot