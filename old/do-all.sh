orig_dir=${PWD}

mkdir ${HOME}/Software
cd ${HOME}
rm -rf Documents Music Public Videos Pictures Templates examples.desktop
mkdir Runs
mkdir Runs/Tutorial-1
mkdir Runs/Tutorial-2
mkdir Runs/Tutorial-3
mkdir Runs/Tutorial-4
mkdir Runs/Tutorial-5
mkdir Runs/Tutorial-6

cd ${orig_dir}
./install-ubuntu-packages.sh
./install-manual.sh 
./install-plumed.sh
./install-lammps.sh
./install-gromacs.sh
./install-vmd.sh








