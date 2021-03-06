      SUBROUTINE repair_units
*
*
*       Initialization of units & scaling factors.
*       Equivalent to Nbody's units.f, only without writing to files
*       ------------------------------------------
*
      INCLUDE 'common6.h'
*
*
*       Define GM & PC in cgs units and #AU in pc (2008 IAU values).
      GM = 1.32712442099D+26
      AU = 1.49597870700D+13
      PC = 1296000.0D0/TWOPI*AU !3.0856776e+18
*
*       Form scaling factors for binary periods A*SQRT(A/M) to yrs and days.
      YRS = (RBAR*1296000.0D0/TWOPI)**1.5/SQRT(ZMBAR)
      DAYS = 365.25*YRS
*
*       Specify conversion factors for lengths to solar radii & AU.
      RSUN = 6.957D+10
      SU = PC/RSUN*RBAR
      RAU = PC/AU*RBAR
*
*       Copy solar mass scaling to new variable (M = BODY*<M>).
      SMU = ZMBAR
*
*     Form time scale in seconds and velocity scale in km/sec.
      TSTAR = SQRT(PC/GM)*PC

*     Convert time scale from units of seconds to million years.
      TSTAR = TSTAR/(3.15576D+07*1.0D+06)

C       IF (KZ(22).NE.10) THEN
C          VSTAR = 1.0D-05*SQRT(GM/PC)
C *
C *       Ensure ZMBAR & RBAR > 0 (=0: assume <M>/Sun = 1, RBAR = 1 pc).
C          IF (ZMBAR.LE.0.0D0) ZMBAR = FLOAT(N)/ZMASS
C          IF (RBAR.LE.0.0D0) RBAR = 1.0
C *
C *       Scale to working units of RBAR in pc & ZMBAR in solar masses.
C          TSTAR = TSTAR*SQRT(RBAR**3/(ZMASS*ZMBAR))
C          VSTAR = VSTAR*SQRT(ZMASS*ZMBAR/RBAR)
C       ELSE
C *     USE scale factor from original input data instead
C          TSTAR = TSTAR*SQRT(RBAR**3/ZMBAR)
C       END IF

      TSTAR = TSTAR * SQRT(RBAR ** 3 / ZMBAR)

      write(*,*) "TSTAR =", TSTAR
*
*       Copy TSTAR to secondary time-scale factor.
      TSCALE = TSTAR
*
*       Define relevant parameter for the GR case (RZ = 6*<m>/c^2).
      CLIGHT = 3.0D+05/VSTAR
      RZ = 6.0*ZMASS/(FLOAT(N)*CLIGHT**2)
*

      RETURN
*
      END SUBROUTINE repair_units
