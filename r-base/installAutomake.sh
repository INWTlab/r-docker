#!/bin/bash

VERSION=${1}

function install_automake() {
    wget http://ftp.gnu.org/gnu/automake/automake-$VERSION.tar.gz \
        && tar -xvf automake-$VERSION.tar.gz \
        && cd automake-$VERSION \
        && ./configure --prefix=/usr/local/automake-$VERSION \
        && make \
        && make install \
        && cd .. \
        && rm automake-$VERSION.tar.gz \
        && rm -rf automake-$VERSION \
        && rm -f /usr/local/bin/aclocal-$VERSION \
        && rm -f /usr/local/bin/automake-$VERSION \
        && ln -s /usr/local/automake-$VERSION/bin/aclocal-$VERSION /usr/local/bin/ \
        && ln -s /usr/local/automake-$VERSION/bin/automake-$VERSION /usr/local/bin/ \
        && echo "Installed automake in version $VERSION"
}

install_automake