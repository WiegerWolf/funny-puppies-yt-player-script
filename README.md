# What and why?

I had an old HP 5:4 monitor and a Jetson Nano 2Gb which were not used for anything. So I decided to turn them into permanent "funny puppies" TV in my living room.

Unfortunately Jetson comes with a really old Ubuntu image from Nvidia, so I wasn't able to run modern `yt-dlp` and `mpv` in it. I had to pack everything inside Docker.

This is the result.

# Status

In practice I bumped into errors about DRI and DRM devices not available to `mpv` from inside Docker, and inability to access X11 display from within the container.

Even after solving most of the issues, I got `mpv` running and displaying a window buffer, but no video got drawn (instead GUI just stuck while `mpv` was running in the container).

I decided to call it quits and ended up running [screenhappy.io](https://screenhappy.io/) on Chromium instead of puppies videos.

# Learnings

I did learn a couple of new things though:

- Unofficial [YT API](https://yt.lemnoslife.com): `api_url="https://yt.lemnoslife.com/search?part=snippet&maxResults=25&q=funny+puppies&type=video"`
- How to set up python `venv` inside Docker container (see [`Dockerfile`](./Dockerfile))

# Use

## Build the Docker Container

Run the following command in the directory containing your Dockerfile and script:

```bash
docker build -t yt-video-player .
```

## Run the Docker Container

Running the container can be tricky due to the need for X11 display for mpv. If you're running on a Linux host and want to try displaying the GUI, you can pass the X11 display socket and environment variable like this:

```bash
./run.sh
```
