orig_dir=${PWD}
cd ${HOME}/software/plumed2-ves
git pull
make -j 4
cd ${orig_dir}

