
# Script for installing PLUMED 2 with the VES module and LAMMPS and GROMACS
# that are patched with that version of PLUMED 2.
# Requirements are at least git, c++ compiler, mpi lib (e.g. openmpi),
# and perhaps something more
#
# The software will be installed into directory given by
# the INSTALL_DIR variable. Be careful not to overwrite other installtions.

# User configurable variables
#
# Directory to install the software
INSTALL_DIR=${HOME}/VES-Tutorial
# YES if you want to install VMD also
INSTALL_VMD=YES
# YES if you want to install GROMACS also
INSTALL_GROMACS=NO
# YES if shortcuts to the manual should be placed on the desktop
MANUAL_DESKTOP_SHORTCUTS=YES

#
mkdir ${INSTALL_DIR}
cp ~/.bashrc ~/.bashrc.ves-backup-Feb2017
cd ${INSTALL_DIR}
mkdir Runs
mkdir Runs/Tutorial-1
mkdir Runs/Tutorial-2
mkdir Runs/Tutorial-3
mkdir Runs/Tutorial-4
mkdir Runs/Tutorial-5
mkdir Runs/Tutorial-6


echo "# Added for VES tutorial on: $(date)" >> ~/.bashrc

# PLUMED 2 Manual with VES tutorial
cd ${INSTALL_DIR}
wget http://github.com/ves-code/doc-ves-master/archive/gh-pages.zip
unzip gh-pages.zip
rm -f gh-pages.zip
mv doc-ves-master-gh-pages ${INSTALL_DIR}/VES-Manual
if [[ "$MANUAL_DESKTOP_SHORTCUTS" == "YES" ]]
then
  ln -sf ${INSTALL_DIR}/VES-Manual/index.html ${HOME}/Desktop/PLUMED-Manual
  ln -sf ${INSTALL_DIR}/VES-Manual/user-doc/html/ves_tutorial_lugano_2017.html ${HOME}/Desktop/VES-Tutorials
fi
################################

# PLUMED 2
cd ${INSTALL_DIR}
git clone https://github.com/ves-code/plumed2-ves.git plumed2-ves
cd plumed2-ves
plumed_dir=${PWD}
source ${PWD}/sourceme.sh
./configure  --enable-matheval --enable-modules=all
make -j 4
echo "source ${plumed_dir}/sourceme.sh" >> ~/.bashrc
################################

# LAMMPS
cd ${INSTALL_DIR}
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
cd ..
lammps_dir=${PWD}
echo "PATH=\$PATH:${lammps_dir}/src" >> ~/.bashrc
#echo "alias lmp_mpi=\"${lammps_dir}/src/lmp_mpi\"" >> ~/.bashrc
################################

# VMD
if [[ "$INSTALL_VMD" == "YES" ]]
then
cd ${INSTALL_DIR}
wget http://www.ks.uiuc.edu/Research/vmd/vmd-1.9.3/files/final/vmd-1.9.3.bin.LINUXAMD64-CUDA8-OptiX4-OSPRay111p1.opengl.tar.gz
tar xvf `ls vmd-1.9.3*tar.gz`
rm -f vmd-1.9.3*tar.gz
mv vmd-1.9.3 vmd-1.9.3-source
cd vmd-1.9.3-source
mkdir ${INSTALL_DIR}/vmd
mkdir ${INSTALL_DIR}/vmd/bin
mkdir ${INSTALL_DIR}/vmd/lib
export VMDINSTALLBINDIR=${INSTALL_DIR}/vmd/bin
export VMDINSTALLLIBRARYDIR=${INSTALL_DIR}/vmd/lib
./configure
cd src
make install
cd ../../
rm -rf vmd-1.9.3-source
echo "PATH=\$PATH:${VMDINSTALLBINDIR}" >> ~/.bashrc
fi
################################

# Gromacs
if [[ "$INSTALL_GROMACS" == "YES" ]]
then
cd ${INSTALL_DIR}
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
cd ${INSTALL_DIR}
rm -rf gromacs-5.1.4-source
gromacs_dir=${GROMACS_ROOT}
echo "source ${gromacs_dir}/bin/GMXRC" >> ~/.bashrc
fi
################################
echo "#-------------------" >> ~/.bashrc

echo " "
echo "#############################################"
echo " "
echo "Everything done!"
echo ""
echo "The Manual is installed at ${INSTALL_DIR}/VES-Manual"
echo ""
echo "The following commands have been added to your ~\.bashrc"
echo " "
echo "source ${plumed_dir}/sourceme.sh"
echo "PATH=\$PATH:${lammps_dir}/src"
#echo "alias lmp_mpi=\"${lammps_dir}/src/lmp_mpi\""
if [[ "$INSTALL_VMD" == "YES" ]]; then echo "PATH=\$PATH:${VMDINSTALLBINDIR}"; fi
if [[ "$INSTALL_GROMACS" == "YES" ]]; then echo "source ${gromacs_dir}/bin/GMXRC"; fi
echo " "
echo "#############################################"
echo " "
