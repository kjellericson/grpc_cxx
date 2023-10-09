FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update

RUN apt-get install -y build-essential autoconf libtool pkg-config curl \
    software-properties-common git

# Install latest cmake
RUN curl https://apt.kitware.com/keys/kitware-archive-latest.asc | apt-key add -
RUN add-apt-repository 'deb https://apt.kitware.com/ubuntu/ focal main'
RUN apt install -y cmake

# clang and LLVM C++ lib is only required for sanitizer builds
RUN apt-get install -y clang libc++-dev

#v1.59.0 from 2023-09-25
RUN git clone -b v1.59.0 https://github.com/grpc/grpc ;\
    cd grpc ; \
    git submodule update --init

# Compile grpc
RUN cd grpc; \
    mkdir -p cmake/build ;\
    cd cmake/build ;\
    cmake ../.. ;\
    make

# Build release packages
RUN cd grpc;\
    mkdir -p cmake/build ;\
    cd cmake/build ;\
    absl_DIR = /grpc/cmake/build/third_party/abseil-cpp/ \
    cmake ../.. -DgRPC_INSTALL=ON                \
              -DCMAKE_BUILD_TYPE=Release       \
              -DgRPC_ABSL_PROVIDER=package     \
              -DgRPC_CARES_PROVIDER=package    \
              -DgRPC_PROTOBUF_PROVIDER=package \
              -DgRPC_RE2_PROVIDER=package      \
              -DgRPC_SSL_PROVIDER=package      \
              -DgRPC_ZLIB_PROVIDER=package ;\
    make ;\
    make install
