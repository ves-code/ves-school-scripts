orig_dir=${PWD}

cd ${HOME}/Software

#git clone -b stable https://github.com/lammps/lammps.git lammps
wget http://lammps.sandia.gov/tars/lammps-stable.tar.gz
tar xvf lammps-stable.tar.gz 
rm -rf lammps-stable.tar.gz 
mv $(ls | grep lammps-) lammps

cd lammps

source ${HOME}/Software/plumed2-ves/sourceme.sh
plumed --no-mpi patch -p -f -e lammps-6Apr13

cd src
make yes-USER-PLUMED
make yes-RIGID
make yes-KSPACE
make yes-MOLECULE
make mpi

sudo ln -sf ${HOME}/Software/lammps/src/lmp_mpi /usr/local/bin/

cd ${orig_dir}




