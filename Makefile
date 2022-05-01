include .env

.docker_image: Dockerfile .env
	docker pull $(HELLO_WORLD_DOCKER_IMAGE)
	touch .docker_image

run: .docker_image
	docker run $(HELLO_WORLD_DOCKER_IMAGE)
