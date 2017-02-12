orig_dir=${PWD}

cd ${HOME}/software

git clone -b stable https://github.com/lammps/lammps.git lammps

cd lammps
plumed --no-mpi patch -p -f -e lammps-6Apr13

cd src
make yes-USER-PLUMED
make yes-RIGID
make yes-KSPACE
make yes-MOLECULE
make mpi

sudo ln -sf ${HOME}/software/lammps/src/lmp_mpi /usr/local/bin/

cd ${orig_dir}




