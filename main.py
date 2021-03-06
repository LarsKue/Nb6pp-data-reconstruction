
import subprocess

import numpy as np
from pathlib import Path
import shutil


def mkbool(x):
    if x:
        return "T"

    return "F"

def main(argv: list) -> int:

    # my home directory on Kepler
    home = Path("/home/Tit5/larskue")

    # bhusan
    # times = np.arange(0, 66830 + 1, 10)
    # bhusan = Path("/work/Tit3/bhusan/Bhusan/2020.05/Run_dat.10.08/")
    # bdatpath = bhusan / Path("bdat.9")
    # confpath = bhusan / Path("conf.3")
    # epochpath = home / Path("bachelor/bhusan/epochs")
    # opath = home / Path("bachelor/bhusan/output/")

    # albrecht rapid
    times = np.arange(0, 51300 + 1, 10)
    albrecht = Path("/work/Tit3/albrechtk")
    bdatpath = home / Path("bachelor/albrecht/rapid/bdat.9")
    confpath = albrecht / Path("conf.3_rapidSNe")
    epochpath = home / Path("bachelor/albrecht/rapid/epochs")
    opath = home / Path("bachelor/albrecht/rapid/output")

    # albrecht delayed
    # times = np.arange(1, 61461 + 1, 10)
    # bdatpath = home / Path("bachelor/albrecht/delayed/bdat.9")
    # confpath = albrecht / Path("conf.3_delayedSNe")
    # epochpath = home / Path("bachelor/albrecht/delayed/epochs")
    # opath = home / Path("bachelor/albrecht/delayed/output")


    # test runs
    # ipath = Path("input")
    # opath = Path("output")

    # compile the program
    # subprocess.run(["make", "build"])

    # clear output and epoch directories if they contain files
    if epochpath.isdir() and any(epochpath.iterdir()):
        shutil.rmtree(epochpath)
    if opath.isdir() and any(opath.iterdir()):
        shutil.rmtree(opath)

    # recreate the directories, not sure if this is necessary
    epochpath.mkdir(exists_ok=True)
    opath.mkdir(exists_ok=True)


    read_epoch = False
    write_sev = False

    oepochs = None
    iepochs = None

    for time in times:
        if read_epoch:
            # remove old epoch input file
            if iepochs is not None:
                # iepochs.unlink()
                pass

            # define input epochs file
            iepochs = epochpath / Path(f"epochs.99_{time}")

            if oepochs is not None:
                # move or copy the output file to input if this is not the first iteration
                # shutil.move(oepochs, iepochs)
                shutil.copy(oepochs, iepochs)

        print(f"Reconstructing t={time}")
        subprocess.run(["make", "run", f"time={time}", f"bdat={bdatpath}/", f"conf={confpath}/", f"epoch={epochpath}/", f"output={opath}/", f"readepoch={mkbool(read_epoch)}", f"writesev={mkbool(write_sev)}"], stdout=subprocess.DEVNULL)
        read_epoch = True
        
        # save the last epochs output file path
        oepochs = epochpath / Path(f"epochs.100_{time}")




    return 0

if __name__ == "__main__":
    import sys
    main(sys.argv)
