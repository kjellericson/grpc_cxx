# GRPC CXX compile in docker

It is a little mess to compile c++ with GRPC. It is a bigger mess if you have a team that need to setup the same environment.
This stuff help you to run the stuff in a docker container.

The example code is taken from https://github.com/grpc/grpc and for an easier test.

## Setup

Run `make docker-build` to prepare the docker image.
This build takes some time...

## Compile

Run `make compile` to compile example.
This will run the script src/compile.sh in docker.
The src-folder is mapped and the result can be found in src/build-folder.

You also have a `make clean` command that just deletes the build folder.

## Test

Start two terminals and run `src/build/greeter_server` and `src/build/greeter_client` in each terminal.

## Bash

You can start a bash in the image with `make bash` in case you like to test some changes.

## Did it help you?

Send me an email at kjell@haxx.se if this helped you.

Make a merge request if you do some improvements.
