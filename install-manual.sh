wget http://github.com/ves-code/doc-ves-master/archive/gh-pages.zip
unzip gh-pages.zip 
rm -f gh-pages.zip
mv doc-ves-master-gh-pages ${HOME}/VES-MANUAL
ln -sf ${HOME}/VES-MANUAL/index.html ${HOME}/Desktop/VES_Manual

