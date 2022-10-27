# from a simple image that only has shell on it
FROM busybox

# build a container and run the echo command.
RUN echo "building simple docker image"

# after the container above exists, save it into an image and then run a container that echoes Hello container
CMD echo "Hello container"
