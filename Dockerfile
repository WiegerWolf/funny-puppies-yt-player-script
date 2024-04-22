# Use Alpine Linux as the base image
FROM alpine:latest

# Install necessary packages including Python and its tools
RUN apk add --no-cache \
    curl \
    jq \
    mpv \
    python3 \
    py3-pip \
    ffmpeg

# Setup Python virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install yt-dlp in the virtual environment
RUN pip install --upgrade pip \
    && pip install yt-dlp

# Ensure mpv uses yt-dlp from the virtual environment
RUN echo "script-opts=ytdl_hook-ytdl_path=/opt/venv/bin/yt-dlp" > /etc/mpv/mpv.conf

# Copy the script into the container
COPY yt-play.sh /usr/local/bin/yt-play.sh

# Make sure the script is executable
RUN chmod +x /usr/local/bin/yt-play.sh

# Debug: List files in /usr/local/bin to verify
RUN ls -lah /usr/local/bin/

# Set the entrypoint to the script
CMD ["/usr/local/bin/yt-play.sh"]
