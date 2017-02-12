wget http://www.ks.uiuc.edu/Research/vmd/vmd-1.9.3/files/final/vmd-1.9.3.bin.LINUXAMD64-CUDA8-OptiX4-OSPRay111p1.opengl.tar.gz
tar xvf `ls vmd-1.9.3*tar.gz`
cd vmd-1.9.3
./configure
cd src
sudo make install
cd ../../
rm -f vmd-1.9.3*tar.gz

