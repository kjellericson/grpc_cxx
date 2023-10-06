
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: docker-build
docker-build:
	docker-compose build

.PHONY: bash
bash:
	docker run -it -v $(ROOT_DIR)/src:/src --workdir /src grpc-cxx /bin/bash

.PHONY: compile
compile:
	docker run -it -v $(ROOT_DIR)/src:/src --workdir /src grpc-cxx /bin/bash -c "./compile.sh"

.PHONY: clean
clean:
	docker run -it -v $(ROOT_DIR)/src:/src --workdir /src grpc-cxx /bin/bash -c "rm -fr build"
