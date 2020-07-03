TAG?=latest

build-webserver:
	@docker build webserver -t ${TAG}

push-webserver:
	@docker push webserver:${TAG}

install-webserver:
	@helm upgrade --install webserver charts/webserver
