Run a basic example
```bash
docker build -t hello .
[+] Building 4.5s (6/6) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                                                 0.0s
 => => transferring dockerfile: 331B                                                                                                                                                                 0.0s
 => [internal] load .dockerignore                                                                                                                                                                    0.0s
 => => transferring context: 2B                                                                                                                                                                      0.0s
 => [internal] load metadata for docker.io/library/busybox:latest                                                                                                                                    3.5s
 => [1/2] FROM docker.io/library/busybox@sha256:6bdd92bf5240be1b5f3bf71324f5e371fe59f0e153b27fa1f1620f78ba16963c                                                                                     0.5s
 => => resolve docker.io/library/busybox@sha256:6bdd92bf5240be1b5f3bf71324f5e371fe59f0e153b27fa1f1620f78ba16963c                                                                                     0.0s
 => => sha256:6bdd92bf5240be1b5f3bf71324f5e371fe59f0e153b27fa1f1620f78ba16963c 2.29kB / 2.29kB                                                                                                       0.0s
 => => sha256:dacd1aa51e0b27c0e36c4981a7a8d9d8ec2c4a74bf125c0a44d0709497a522e9 527B / 527B                                                                                                           0.0s
 => => sha256:bc01a3326866eedd68525a4d2d91d2cf86f9893db054601d6be524d5c9d03981 1.46kB / 1.46kB                                                                                                       0.0s
 => => sha256:22b70bddd3acadc892fca4c2af4260629bfda5dfd11ebc106a93ce24e752b5ed 772.99kB / 772.99kB                                                                                                   0.4s
 => => extracting sha256:22b70bddd3acadc892fca4c2af4260629bfda5dfd11ebc106a93ce24e752b5ed                                                                                                            0.1s
 => [2/2] RUN echo "building simple docker image"                                                                                                                                                    0.3s
 => exporting to image                                                                                                                                                                               0.0s
 => => exporting layers                                                                                                                                                                              0.0s
 => => writing image sha256:0d4d3c16fc2129fd78cf8300c853d747b932c955b9cee357d3ecdfb1b8078d14                                                                                                         0.0s
 => => naming to docker.io/library/hello
 
docker run --rm hello
Hello container
```


Multi-stage build
```bash
# Initial dockerfile
docker build -f ./Dockerfile.multi -t too-big .

docker run --rm too-big
google is this big
      6      14     220
      
docker images
REPOSITORY   TAG       IMAGE ID       CREATED              SIZE
<none>       <none>    bf2a83deaefa   About a minute ago   182MB
too-big      latest    f30f79cf7a19   About a minute ago   182MB
hello        latest    0d4d3c16fc21   30 minutes ago       1.24MB

# Improved dockerfile
docker build -f ./Dockerfile.multi2 -t too-big-2 .

docker run --rm too-big-2
google is this big
      6      14     220

docker images
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
too-big-2    latest    d4d4eaa03b2b   23 seconds ago   5.54MB
<none>       <none>    bf2a83deaefa   7 minutes ago    182MB
too-big      latest    f30f79cf7a19   7 minutes ago    182MB
hello        latest    0d4d3c16fc21   35 minutes ago   1.24MB
```