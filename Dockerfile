# Use Alpine Linux as the base image
FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache \
    curl \
    jq \
    mpv \
    python3 \
    py3-pip \
    ffmpeg \
    && pip3 install --upgrade yt-dlp

# Copy the script into the container
COPY yt-play.sh /usr/local/bin/yt-play.sh

# Make sure the script is executable
RUN chmod +x /usr/local/bin/yt-play.sh

# Ensure mpv uses yt-dlp
RUN echo "ytdl-raw-options=source-address=0.0.0.0" > /etc/mpv/mpv.conf
RUN echo "script-opts=ytdl_hook-ytdl_path=yt-dlp" >> /etc/mpv/mpv.conf

# Set the entrypoint to the script
# ENTRYPOINT ["/usr/local/bin/yt-play.sh"]

CMD ["/bin/sh"] # Start a shell if no specific command is provided
