sha=$1
cd ~/
rm -rf src
git clone https://github.com/rakudo/rakudo.git src
cd src/
git pull
git checkout $sha
perl Configure.pl --backend=moar --gen-moar --gen-nqp
make
make install
