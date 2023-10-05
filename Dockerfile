FROM ubuntu

RUN apt-get update

RUN apt-get install -y build-essential autoconf libtool pkg-config

RUN apt-get install -y cmake

# clang and LLVM C++ lib is only required for sanitizer builds
RUN apt-get install -y clang libc++-dev

RUN apt-get install -y git

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
