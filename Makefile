USER_NAME ?= justcodingys
TEMPLATE_NAME ?= janus-webrtc-gateway-docker

remove:
	@docker system prune -a

build:
	@docker build -t $(USER_NAME)/$(TEMPLATE_NAME):1.0 .

build-nocache:
	@docker build --no-cache -t $(USER_NAME)/$(TEMPLATE_NAME):1.0 .

bash: 
	@docker run --net=host -v /home/ubuntu:/ubuntu --name="janus" -it -t $(USER_NAME)/$(TEMPLATE_NAME):1.0 /bin/bash

attach: 
	@docker exec -it janus /bin/bash

push:
	@docker push $(USER_NAME)/$(TEMPLATE_NAME):1.0

run: 
	@docker run --net=host --name="janus" -it -t $(USER_NAME)/$(TEMPLATE_NAME):1.0

run_daemon:
	@docker run --net=host --name="janus" -it -d -t $(USER_NAME)/$(TEMPLATE_NAME):1.0

run-mac: 
	@docker run -p 80:80 -p 8088:8088 -p 8188:8188 --name="janus" -it -t $(USER_NAME)/$(TEMPLATE_NAME):1.0

run-hide: 
	@docker run --net=host --name="janus" -it -t $(USER_NAME)/$(TEMPLATE_NAME):1.0 >> /dev/null

stream:
	ffmpeg -re -stream_loop -1 -i ./stream/videos/test.mp4 -vcodec libx264 -vb 1500k -minrate 1500k -maxrate 1500k -bufsize 1500k -s 858x480 -g 60 -tune zerolatency -bf 0 -profile:v baseline -an -f rtp rtp://15.165.13.82:8004?pkt_size=1300 -vn -acodec libopus -ab 128k -ac 2 -ar 48000 -f rtp rtp://15.165.13.82:8002?pkt_size=1300