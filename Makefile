ps:
	docker-compose ps

build:
	docker-compose build

stop:
	docker-compose stop

down:
	docker-compose down

up:
	docker-compose up -d

restart:
	docker-compose restart

bash:
	docker run -it grpc-cxx /bin/bash

logs:
	docker container logs -f grpc-cxx

