orig_dir=${PWD}

cd ${HOME}/Software

git clone https://github.com/ves-code/plumed2-ves.git plumed2-ves

cd plumed2-ves 
source ${PWD}/sourceme.sh
./configure  --enable-matheval --enable-modules=all 
make -j 4 

echo "source ${PWD}/sourceme.sh" >> ~/.bashrc
echo ":let &runtimepath.=','.\$PLUMED_VIMPATH" >> ~/.vimrc
echo ":set completeopt=longest,menuone"       >> ~/.vimrc

cd ${orig_dir}




