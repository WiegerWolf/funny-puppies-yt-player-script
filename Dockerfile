FROM alpine:latest

# Install necessary packages including Python and its tools
RUN apk add --no-cache \
    curl \
    jq \
    mpv \
    python3 \
    py3-pip \
    ffmpeg \
    bash  # Add bash if your script uses bash-specific features

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
    && sed -i 's/\r$//' /usr/local/bin/yt-play.sh  # Remove carriage return characters

# Verify that the script is correctly formatted and executable
RUN ls -lah /usr/local/bin/ \
    && head -n 1 /usr/local/bin/yt-play.sh

# Set the entrypoint to the script
# ENTRYPOINT ["/usr/local/bin/yt-play.sh"]

CMD ["/bin/sh"] # Start a shell if no specific command is provided
