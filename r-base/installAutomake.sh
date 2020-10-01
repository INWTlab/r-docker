#!/bin/bash

VERSION=${1}

wget http://ftp.gnu.org/gnu/automake/automake-$VERSION.tar.gz
tar -xvfz automake-$VERSION.tar.gz
cd automake-$VERSION
./configure --prefix=/usr/local/automake-$VERSION
make
make install
cd ..
rm automake-$VERSION.tar.gz
rm -rf automake-$VERSION

ln -s /usr/local/automake-$VERSION/bin/aclocal-$VERSION /usr/local/bin/
ln -s /usr/local/automake-$VERSION/bin/automake-$VERSION /usr/local/bin/

echo Installed automake in version $VERSION

                    