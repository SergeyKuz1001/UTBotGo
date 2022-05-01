include .env

build: .docker_image

.docker_image: Dockerfile .env
	docker pull ghcr.io/sergeykuz1001/hello_world:0.0
	touch .docker_image
