      subroutine reconstruct
*       this subroutine reconstructs variables
*       that cannot be directly read from files

        include 'common_repair.h'

      TTOT = TREAD

      do JPAIR = 1, NPAIRS
C       do JPAIR = 1, 5

        write(*,*) 'reconstructing pair ', JPAIR

        J1 = 2*JPAIR - 1
        J2 = 2*JPAIR

        BODY(J1) = BODYXZMBAR(J1) / ZMBAR
        BODY(J2) = BODYXZMBAR(J2) / ZMBAR

        RIS(JPAIR) = RIS(JPAIR) / RBAR
        VIS(JPAIR) = VIS(JPAIR) / VSTAR
        SEMIS(JPAIR) = SEMIS(JPAIR) / RAU

        H(JPAIR) = -0.5 * (BODY(J1) + BODY(J2)) / SEMIS(JPAIR)

        
*       TODO:
C       RM = SEMI*(1.0 - E0)/MAX(RADIUS(J1),RADIUS(J),1.0D-20)

*       Verify
        write(*,*) 'Verify:  '
        write(*,*) 'BODY(J1):', BODY(J1)
        write(*,*) 'BODY(J2):', BODY(J2)
        write(*,*) 'H(JPAIR):', H(JPAIR)
        write(*,*) '==================================================='

      end do


*       TODO:
*           - TTOT, TPHYS, TCHAR, Time in general
*           - BODY0?
*           - IFIRST?
*           - NAMEG
*           - NCH
*           - CM
*           - 



      

      end subroutine reconstruct