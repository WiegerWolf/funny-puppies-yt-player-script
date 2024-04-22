#!/bin/bash

# Set the DISPLAY variable for graphical output
#export DISPLAY=:0

# Grant access to the X server for root (common for Docker containers running GUI apps)
xhost +SI:localuser:root

# Run the Docker container
docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v /run/user/$(id -u)/pulse:/run/user/$(id -u)/pulse \
  -v $HOME/.Xauthority:/root/.Xauthority:ro \
  -e XDG_RUNTIME_DIR=/tmp \
  --network host \
  yt-video-player

# Restrict X server access after the container stops
xhost -SI:localuser:root
