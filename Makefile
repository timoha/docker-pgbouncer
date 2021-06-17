IMAGE_NAME=timoha/pgbouncer
IMAGE_VERSION=1.15.0
PLATFORM=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64

docker:
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .
	docker tag $(IMAGE_NAME):$(IMAGE_VERSION) $(IMAGE_NAME):latest

push:
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)
	docker push $(IMAGE_NAME):latest

multi: Dockerfile
	docker buildx create --platform $(PLATFORM) --name multibuild --use
	docker buildx inspect multibuild --bootstrap
	docker buildx build --platform $(PLATFORM) -t $(IMAGE_NAME):$(IMAGE_VERSION) --push .
	docker buildx rm multibuild
