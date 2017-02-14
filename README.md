# ves-school-scripts

Installation scripts for
the [MARVEL-VES school](https://sites.google.com/site/vesschool2017/) in Lugano February 2017


# Scripts
Scripts to install on Ubuntu and other Linux the software needed
for the VES tutorial.

It will install
- PLUMED 2 with VES module
- Manual and VES tutorial
- VMD (64 bit version)
- LAMMPS patched with PLUMED 2
- GROMACS patched with PLUMED 2

Requirements are to have at least git, c++ compiler, cmake, mpi library (e.g. openmpi).
See also Packages needed below

To install the software and tutorial you need to run the _install-ves-tutorial.sh_
script. Everything will be installed in a self-contained directory
that is given by INSTALL_DIR variable in that script. By default it is
${HOME}/VES-Tutorial.

If you have a 32 bit system you should will need to run _install-vmd-32bit.sh_
to install a 32 bit version of VMD.


# Packages needed in Ubuntu
The installation and tutorial has been tested to work with a Ubuntu 14 and 16
where the following packages have been installed:
libmatheval-dev, libfftw3-dev, gsl-bin, libgsl0-dev, libopenmpi-dev,
openmpi-bin, libatlas-base-dev, git, cmake, gnuplot-qt, grace, build-essential,
python-gnuplot, vim, emacs, gfortran, python-numpy, python-scipy,
python-matplotlib, python-statsmodels, gawk.

You can use the _install-ubuntu-packages.sh_ to install these packages in Ubuntu.
