# Use an Ubuntu base image
FROM ubuntu:latest

# Avoiding user interaction with tzdata
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    mpv \
    yt-dlp \
    && rm -rf /var/lib/apt/lists/*

# Copy the script into the container
COPY yt-play.sh /usr/local/bin/yt-play.sh

# Make sure the script is executable
RUN chmod +x /usr/local/bin/yt-play.sh

# Set the entrypoint to the script
ENTRYPOINT ["/usr/local/bin/yt-play.sh"]
