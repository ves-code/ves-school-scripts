


# Script for installing PLUMED 2 with the VES module and LAMMPS and GROMACS
# that are patched with that versio of PLUMED 2.
# Requirements are at least git, c++ compiler, mpi lib (e.g. openmpi),
# and perhaps something more
#
# The software will be installed into directory given by
# the INSTALL_ROOT variable. Be careful not to overwrite other installtions.

INSTALL_ROOT=${HOME}/Software_VES

cd ${INSTALL_ROOT}

# PLUMED 2 Manual with VES tutorial
wget http://github.com/ves-code/doc-ves-master/archive/gh-pages.zip
unzip gh-pages.zip
rm -f gh-pages.zip
mv doc-ves-master-gh-pages ${INSTALL_ROOT}/VES-Manual
ln -sf ${INSTALL_ROOT}/VES-Manual/index.html ${HOME}/Desktop/VES-Manual
ln -sf ${INSTALL_ROOT}/VES-Manual/user-doc/html/ves_tutorial_lugano_2017.html ${HOME}/Desktop/VES-Tutorials
################################

# PLUMED 2
git clone https://github.com/ves-code/plumed2-ves.git plumed2-ves
cd plumed2-ves
source ${PWD}/sourceme.sh
./configure  --enable-matheval --enable-modules=all
make -j 4
#echo "source ${PWD}/sourceme.sh" >> ~/.bashrc
source ${HOME}/Software/plumed2-ves/sourceme.sh
plumed_dir=${PWD}
################################

# LAMMPS
cd ${INSTALL_ROOT}
wget http://lammps.sandia.gov/tars/lammps-stable.tar.gz
tar xvf lammps-stable.tar.gz
rm -rf lammps-stable.tar.gz
mv $(ls | grep lammps-) lammps
cd lammps
plumed --no-mpi patch -p -f -e lammps-6Apr13
cd src
make yes-USER-PLUMED
make yes-RIGID
make yes-KSPACE
make yes-MOLECULE
make yes-MANYBODY
make mpi
lammps_dir=${PWD}
################################

# Gromacs
cd ${INSTALL_ROOT}
wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-5.1.4.tar.gz
tar xvf gromacs-5.1.4.tar.gz
rm -f gromacs-5.1.4.tar.gz
mv gromacs-5.1.4 gromacs-5.1.4-source
GROMACS_ROOT=${PWD}/gromacs-5.1.4
cd gromacs-5.1.4-source
plumed --no-mpi patch -p -f --shared -e gromacs-5.1.4
mkdir build_serial_static
cd build_serial_static
cmake .. \
  -DGMX_BUILD_OWN_FFTW=ON \
  -DCMAKE_INSTALL_PREFIX=${GROMACS_ROOT}\
  -DGMX_DEFAULT_SUFFIX=ON \
  -DGMX_DOUBLE=OFF \
  -DGMX_MPI=OFF \
  -DGMX_OPENMP=OFF \
  -DBUILD_SHARED_LIBS=OFF \
  -DGMX_GPU=OFF
make -j 4
make install
cd ..
mkdir build_mpi_static
cd build_mpi_static
cmake .. \
  -DGMX_BUILD_OWN_FFTW=ON \
  -DCMAKE_INSTALL_PREFIX=${GROMACS_ROOT}\
  -DGMX_DEFAULT_SUFFIX=ON \
  -DGMX_DOUBLE=OFF \
  -DGMX_MPI=ON \
  -DGMX_OPENMP=OFF \
  -DBUILD_SHARED_LIBS=OFF \
  -DGMX_GPU=OFF \
  -DGMX_BUILD_MDRUN_ONLY=ON
make -j 4
make install
cd ..
cd ..
rm -rf gromacs-5.1.4-source
gromacs_dir=${GROMACS_ROOT}
################################




echo " "
echo "#############################################"
echo "Everything done!"
echo ""
echo "The Manual is installed at ${INSTALL_ROOT}/VES-Manual"
echo ""
echo "You should add the following to your ~/.bashrc or ~/.profile"
echo " "
echo "source ${plumed_dir}/sourceme.sh"
echo "alias lmp_mpi=\"${lammps_dir}/src/lmp_mpi\""
echo "source ${gromacs_dir}/bin/GMXRC"
echo " "
