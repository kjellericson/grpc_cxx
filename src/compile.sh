#!/bin/sh
## This is the script that will run in the container and do your compile stuff.

mkdir -p build
cd build
cmake ../
make

# Make everything created writeable for everyone.
chmod a+rw -R .