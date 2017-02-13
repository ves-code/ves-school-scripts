rm -rf ${HOME}/VES-Manual
${HOME}/Desktop/VES-Manual
${HOME}/Desktop/VES-Tutorials


wget http://github.com/ves-code/doc-ves-master/archive/gh-pages.zip
unzip gh-pages.zip 
rm -f gh-pages.zip
mv doc-ves-master-gh-pages ${HOME}/VES-Manual
ln -sf ${HOME}/VES-Manual/index.html ${HOME}/Desktop/VES-Manual
ln -sf ${HOME}/VES-Manual/user-doc/html/ves_tutorial_lugano_2017.html ${HOME}/Desktop/VES-Tutorials

