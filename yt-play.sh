#!/bin/bash

# Function to log messages with timestamps
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Loop indefinitely
while true; do
  log "Starting API call to fetch video data..."
  
  # API URL
  api_url="https://yt.lemnoslife.com/search?part=snippet&maxResults=25&q=funny+puppies&type=video"

  # Fetch data using curl and store it in a variable
  response=$(curl -s "$api_url")
  if [ $? -ne 0 ]; then
    log "Error: Failed to fetch data from API."
    sleep 10
    continue
  fi

  log "API data fetched successfully, parsing video IDs..."
  
  # Use jq to extract video IDs and generate URLs
  urls=$(echo "$response" | jq -r '.items[].id.videoId | "https://youtu.be/\(.)"')
  if [ $? -ne 0 ] || [ -z "$urls" ]; then
    log "Error: Failed to parse videos or no videos found."
    sleep 10
    continue
  fi

  log "Video URLs parsed successfully. Starting video playback..."

  # Play each URL with mpv in fullscreen
  for url in $urls; do
    log "Playing video URL: $url"
    mpv --fullscreen --player-operation-mode=pseudo-gui "$url"
    if [ $? -ne 0 ]; then
      log "Error: mpv encountered an error playing $url."
    fi
  done

  log "All videos played. Waiting before the next round of videos..."
  sleep 10
done
