      
      program repair_main

*       initialize some parameters from command line
      call setup()

*       initialize variables and some constants
      call zero()

*       open required files with their original handles
      call open_files()

*       read in variable values from those files
      call read_files()

*       create some constants that are required to reconstruct the data
      call repair_units()

*       reconstruct variables that cannot be directly read from files
      call reconstruct()

*       reconstruct the data files
      call repair_hrplot()

*       write epochs to a separate file
      call write_epochs()

      call close_files()

      end program repair_main