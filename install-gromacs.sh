orig_dir=${PWD}
cd ${HOME}/software

wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-5.1.4.tar.gz 
tar xvf gromacs-5.1.4.tar.gz 
rm -f gromacs-5.1.4.tar.gz 
mv gromacs-5.1.4 gromacs-5.1.4-source

GROMACS_ROOT=${HOME}/software/gromacs-5.1.4

cd gromacs-5.1.4-source

source ${HOME}/software/plumed2-ves/sourceme.sh
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
make
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
make
make install
cd ..

cd ..

rm -rf gromacs-5.1.4-source

echo "source ${GROMACS_ROOT}/bin/GMXRC" >> ~/.profile

cd ${orig_dir}


