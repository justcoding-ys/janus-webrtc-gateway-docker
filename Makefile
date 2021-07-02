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

stream:
	ffmpeg -re -stream_loop -1 -i ./stream/videos/test.mp4 -vcodec libx264 -vb 1500k -minrate 1500k -maxrate 1500k -bufsize 1500k -s 858x480 -g 60 -tune zerolatency -bf 0 -profile:v baseline -an -f rtp rtp://15.165.13.82:8004?pkt_size=1300 -vn -acodec libopus -ab 128k -ac 2 -ar 48000 -f rtp rtp://15.165.13.82:8002?pkt_size=1300