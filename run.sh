#!/bin/bash
export DISPLAY=:0  # Make sure to set the DISPLAY variable correctly

xhost +si:localuser:root  # Allow root access to the X server

docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e XDG_RUNTIME_DIR=/tmp \
  yt-video-player

xhost -si:localuser:root  # Remove root access from the X server after you're done
S