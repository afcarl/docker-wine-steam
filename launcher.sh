#!/bin/sh

CONTAINER_NAME=vaporized_wine

( \
	echo 'Trying to run a new data container.' && \
	docker run -ti --privileged \
			-e DISPLAY \
			-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
			-v ~/.Xauthority:/home/wine/.Xauthority \
			-v /dev/snd:/dev/snd \
                        -v /dev/input:/dev/input \
			-v /run/user/`id -u`/pulse/native:/run/user/`id -u`/pulse/native \
			-v `pwd`/shared_directory:/home/wine/shared_directory \
			--net=host \
			--name "$CONTAINER_NAME" \
			winesteam \
	2>/dev/null \
) || ( \
	echo 'The container already exists, relaunching the old old one.' && \
	docker start -ai "$CONTAINER_NAME" \
)
