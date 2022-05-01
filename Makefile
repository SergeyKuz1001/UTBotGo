include .env

build: .docker_image

.docker_image: Dockerfile .env
	docker pull ghcr.io/SergeyKuz1001/hello_world:$(HELLO_WORLD_VERSION)
	touch .docker_image
