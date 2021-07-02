USER_NAME ?= justcodingys
TEMPLATE_NAME ?= janus-webrtc-gateway-docker
TAG ?= 1:0

remove:
	@docker system prune -a

build:
	@docker build -t $(USER_NAME)/$(TEMPLATE_NAME) .

build-nocache:
	@docker build --no-cache -t $(USER_NAME)/$(TEMPLATE_NAME) .

bash: 
	@docker run --net=host -v /home/ubuntu:/ubuntu --name="janus" -it -t $(USER_NAME)/$(TEMPLATE_NAME) /bin/bash

attach: 
	@docker exec -it janus /bin/bash

push:
	@docker push $(USER_NAME)/$(TEMPLATE_NAME):$(TAG)

run: 
	@docker run --net=host --name="janus" -it -t $(USER_NAME)/$(TEMPLATE_NAME)

run_daemon:
	@docker run --net=host --name="janus" -it -d -t $(USER_NAME)/$(TEMPLATE_NAME)

run-mac: 
	@docker run -p 80:80 -p 8088:8088 -p 8188:8188 --name="janus" -it -t $(USER_NAME)/$(TEMPLATE_NAME)

run-hide: 
	@docker run --net=host --name="janus" -it -t $(USER_NAME)/$(TEMPLATE_NAME) >> /dev/null
