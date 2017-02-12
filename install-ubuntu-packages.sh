packages="
libmatheval-dev
libfftw3-dev
gsl-bin
libgsl0-dev
libopenmpi-dev
openmpi-bin
graphviz
doxygen-latex
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
  echo ${p}
  #isudo apt-get install -y ${p}
done
