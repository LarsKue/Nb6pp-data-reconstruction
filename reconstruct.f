      subroutine reconstruct
*       this subroutine reconstructs variables
*       that cannot be directly read from files

        include 'common_repair.h'

      TTOT = TREAD

      do JPAIR = 1, NPAIRS
        if (mod(JPAIR, 500) .eq. 0) then
          write(*,*) 'reconstructing pair ', JPAIR
        end if

        J1 = 2*JPAIR - 1
        J2 = 2*JPAIR

        BODY(J1) = BODYXZMBAR(J1) / ZMBAR
        BODY(J2) = BODYXZMBAR(J2) / ZMBAR

        RIS(JPAIR) = RIS(JPAIR) / RBAR
        VIS(JPAIR) = VIS(JPAIR) / VSTAR
        SEMIS(JPAIR) = SEMIS(JPAIR) / RAU

        H(JPAIR) = -0.5 * (BODY(J1) + BODY(J2)) / SEMIS(JPAIR)

      end do
      
      end subroutine reconstruct