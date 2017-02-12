sudo apt-get update
sudo apt-get upgrade -y 

packages="
libmatheval-dev
libfftw3-dev
gsl-bin
libgsl0-dev
libopenmpi-dev
openmpi-bin
libatlas-base-dev
git
cmake
gnuplot-qt
grace
build-essential
python-gnuplot
vim
emacs
gfortran
python-numpy
python-scipy
python-matplotlib
python-statsmodels
"

for p in ${packages}
do
  sudo apt-get install -y ${p}
done
