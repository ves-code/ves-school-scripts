
# Script for installing PLUMED 2 with the VES module and LAMMPS and GROMACS
# that are patched with that version of PLUMED 2.
# Requirements are at least git, c++ compiler, mpi lib (e.g. openmpi),
# and perhaps something more
#
# The software will be installed into directory given by
# the INSTALL_DIR variable. Be careful not to overwrite other installtions.
#
# Takes around 1.3 Gb of space in total

# User configurable variables
#
# Directory to install the software
INSTALL_DIR=${HOME}/VES-Tutorial
# YES if you want to install VMD also
INSTALL_VMD=YES
# YES if you want to install GROMACS also
INSTALL_GROMACS=YES
# YES if shortcuts to the manual should be placed on the desktop
MANUAL_DESKTOP_SHORTCUTS=YES

PACKAGE_DIR=${PWD}/packages/

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
mkdir Software


echo "# Added for VES tutorial on: $(date)" >> ~/.bashrc

# PLUMED 2 Manual with VES tutorial
cd ${INSTALL_DIR}
unzip ${PACKAGE_DIR}/doc-ves-master.zip
mv doc-ves-master-gh-pages ${INSTALL_DIR}/VES-Manual
if [[ "$MANUAL_DESKTOP_SHORTCUTS" == "YES" ]]
then
  ln -sf ${INSTALL_DIR}/VES-Manual/index.html ${HOME}/Desktop/PLUMED-Manual
  ln -sf ${INSTALL_DIR}/VES-Manual/user-doc/html/ves_tutorial_lugano_2017.html ${HOME}/Desktop/VES-Tutorials
fi
################################

# PLUMED 2
cd ${INSTALL_DIR}/Software
tar xvf ${PACKAGE_DIR}/plumed2-ves.tar.gz
cd plumed2-ves
plumed_dir=${PWD}
./configure  --enable-matheval --enable-modules=all
source ${PWD}/sourceme.sh
make -j 4
echo "source ${plumed_dir}/sourceme.sh" >> ~/.bashrc
################################

# LAMMPS
cd ${INSTALL_DIR}/Software
tar xvf ${PACKAGE_DIR}/lammps-stable.tar.gz
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
echo "PATH=${lammps_dir}/src:\$PATH" >> ~/.bashrc
#echo "alias lmp_mpi=\"${lammps_dir}/src/lmp_mpi\"" >> ~/.bashrc
################################

# VMD
if [[ "$INSTALL_VMD" == "YES" ]]
then
cd ${INSTALL_DIR}/Software
tar xvf `ls ${PACKAGE_DIR}/vmd-1.9.3*tar.gz`
rm -f vmd-1.9.3*tar.gz
mv vmd-1.9.3 vmd-1.9.3-source
cd vmd-1.9.3-source
mkdir ${INSTALL_DIR}/Software/vmd
mkdir ${INSTALL_DIR}/Software/vmd/bin
mkdir ${INSTALL_DIR}/Software/vmd/lib
export VMDINSTALLBINDIR=${INSTALL_DIR}/Software/vmd/bin
export VMDINSTALLLIBRARYDIR=${INSTALL_DIR}/Software/vmd/lib
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
cd ${INSTALL_DIR}/Software
tar xvf ${PACKAGE_DIR}/gromacs-5.1.4.tar.gz
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
cd ${INSTALL_DIR}/Software
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
echo "PATH=${lammps_dir}/src:\$PATH"
#echo "alias lmp_mpi=\"${lammps_dir}/src/lmp_mpi\""
if [[ "$INSTALL_VMD" == "YES" ]]; then echo "PATH=\$PATH:${VMDINSTALLBINDIR}"; fi
if [[ "$INSTALL_GROMACS" == "YES" ]]; then echo "source ${gromacs_dir}/bin/GMXRC"; fi
echo " "
echo "#############################################"
echo " "
