#!/bin/bash
xhost +local:root  # Allow local root to access X11 display

docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e XDG_RUNTIME_DIR=/tmp \
  yt-video-player

xhost -local:root  # Restrict X11 access again
