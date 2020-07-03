TAG?=latest

build-webserver:
	@docker build ./webserver -t ${IMAGE_NAME}${TAG}

push-webserver:
	@docker push ${IMAGE_NAME}:${TAG}

install-webserver:
	@helm upgrade --install webserver charts/webserver
