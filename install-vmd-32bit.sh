# Libs needed
# apt-get install libglu1-mesa libxi-dev libxmu-dev libglu1-mesa-dev

INSTALL_DIR=${HOME}/VES-Tutorial

rm -rf ${INSTALL_DIR}/Software/vmd 

cd ${INSTALL_DIR}/Software
wget http://www.ks.uiuc.edu/Research/vmd/vmd-1.9.2/files/final/vmd-1.9.2.bin.LINUX.opengl.tar.gz 
tar xvf `ls vmd-1.9.2*tar.gz`
rm -f vmd-1.9.2*tar.gz
mv vmd-1.9.2 vmd-1.9.2-source
cd vmd-1.9.2-source
mkdir ${INSTALL_DIR}/Software/vmd
mkdir ${INSTALL_DIR}/Software/vmd/bin
mkdir ${INSTALL_DIR}/Software/vmd/lib
export VMDINSTALLBINDIR=${INSTALL_DIR}/Software/vmd/bin
export VMDINSTALLLIBRARYDIR=${INSTALL_DIR}/Software/vmd/lib
./configure
cd src
make install
cd ../../
rm -rf vmd-1.9.2-source
echo "PATH=\$PATH:${VMDINSTALLBINDIR}" >> ~/.bashrc
