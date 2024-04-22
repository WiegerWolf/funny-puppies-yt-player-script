# Use Ubuntu as the base image
FROM ubuntu:latest

# Avoid timezone prompts
ARG DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages including Python and its tools
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    mpv \
    python3 \
    python3-pip \
    python3-venv \
    ffmpeg \
    bash \
    libegl1-mesa \
    libgl1-mesa-glx \
    libxext6 \
    libxrender1 \
    libxtst6 \
    pulseaudio \
    alsa-utils

# Setup Python virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install yt-dlp in the virtual environment
RUN pip install --upgrade pip \
    && pip install yt-dlp

# Ensure mpv uses yt-dlp from the virtual environment
RUN echo "script-opts=ytdl_hook-ytdl_path=/opt/venv/bin/yt-dlp" > /etc/mpv/mpv.conf

# Copy and prepare the script
COPY yt-play.sh /usr/local/bin/yt-play.sh
RUN chmod +x /usr/local/bin/yt-play.sh \
    && sed -i 's/\r//g' /usr/local/bin/yt-play.sh  # Remove carriage return characters

# Verify that the script is correctly formatted and executable
RUN ls -lah /usr/local/bin/ \
    && head -n 1 /usr/local/bin/yt-play.sh

# Set the entrypoint to the script
# ENTRYPOINT ["/usr/local/bin/yt-play.sh"]

CMD ["/bin/bash"] # Start a shell if no specific command is provided
