      subroutine write_epochs

      include 'common_repair.h'

      do JPAIR = 1, NPAIRS
        J1 = 2 * JPAIR - 1
        J2 = 2 * JPAIR

        write(100, *) NAME(J1), EPOCH(J1), NAME(J2), EPOCH(J2)

      end do

      end subroutine write_epochs