
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))


build:
	docker-compose build

bash:
	docker run -it -v $(ROOT_DIR)/src:/src --workdir /src grpc-cxx /bin/bash

compile:
	docker run -it -v $(ROOT_DIR)/src:/src --workdir /src grpc-cxx /bin/bash -c "./compile.sh"

clean:
	docker run -it -v $(ROOT_DIR)/src:/src --workdir /src grpc-cxx /bin/bash -c "rm -fr build"
