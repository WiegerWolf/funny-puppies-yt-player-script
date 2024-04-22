#!/bin/bash
# Set the DISPLAY variable correctly
export DISPLAY=:0

# Allow root access to the X server
xhost +si:localuser:root

# Run the Docker container with appropriate settings
docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v /run/user/$(id -u)/pulse:/run/user/$(id -u)/pulse \
  -v $HOME/.Xauthority:/root/.Xauthority:ro \
  -e XDG_RUNTIME_DIR=/tmp \
  --device /dev/dri \
  --network host \
  yt-video-player

# Remove root access from the X server after you're done
xhost -si:localuser:root
