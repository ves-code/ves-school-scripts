# Directory to install the software
INSTALL_DIR=${HOME}/VES-Tutorial
# YES if shortcuts to the manual should be placed on the desktop
MANUAL_DESKTOP_SHORTCUTS=YES

# PLUMED 2 Manual with VES tutorial
rm -rf ${INSTALL_DIR}/VES-Manual
cd ${INSTALL_DIR}
wget http://github.com/ves-code/doc-ves-master/archive/gh-pages.zip
unzip gh-pages.zip
rm -f gh-pages.zip
mv doc-ves-master-gh-pages ${INSTALL_DIR}/VES-Manual
if [[ "$MANUAL_DESKTOP_SHORTCUTS" == "YES" ]]
then
  ln -sf ${INSTALL_DIR}/VES-Manual/index.html ${HOME}/Desktop/PLUMED-Manual
  ln -sf ${INSTALL_DIR}/VES-Manual/user-doc/html/ves_tutorial_lugano_2017.html ${HOME}/Desktop/VES-Tutorials
fi
################################

