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
