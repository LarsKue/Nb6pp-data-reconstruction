      subroutine read_epochs

      include 'common_repair.h'

      integer n1, n2
      real*8 e1, e2

      integer read_status

      do 10 JPAIR = 1, NPAIRS

        J1 = 2 * JPAIR - 1
        J2 = 2 * JPAIR

*       read epochs and names from file
        read(99, *, IOSTAT=read_status) n1, e1, n2, e2

        if (abs(e1) .lt. 1E-10 .and. abs(e2) .lt. 1E-10) then
          goto 10
        end if

        if (read_status .lt. 0) then
*           end of file reached
            return
        end if

        do KPAIR = 1, NPAIRS

            K1 = 2 * KPAIR - 1
            K2 = 2 * KPAIR

*           find if the star is present and set epoch at its index
            if (n1 .eq. NAME(K1)) then

                EPOCH(K1) = e1
                EPOCH(K2) = e2

            end if

        end do

   10 end do

      end subroutine read_epochs