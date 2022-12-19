#!/usr/bin/env bash

# ensure dependencies are installed first. On debian this is:
#
# sudo apt update
# sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev tk-dev

PYTHON_VERSION=3.10.5
BUILD_LOCATION=/srv/app/build/python/${PYTHON_VERSION}
INSTALL_LOCATION=/srv/app/install/python/${PYTHON_VERSION}

if [ -z "${PYTHON_VERSION}" ]; then
	echo "You must pass in a PYTHON_VERSION"
	exit 1
fi

if [ ! -d "${BUILD_LOCATION}" ]; then
	mkdir --parents "${BUILD_LOCATION}"
fi

cd "${BUILD_LOCATION}"
# download
curl -O "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz"
# extract
tar -xf Python-${PYTHON_VERSION}.tar.xz

# configure build
# Pass --prefix=<PATH> to change the install location
cd Python-${PYTHON_VERSION}
./configure --enable-optimizations --prefix="${INSTALL_LOCATION}"
make -j 4

make install
