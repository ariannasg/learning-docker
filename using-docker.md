Check where the docker control socket is (just a file)
```bash
ls /var/run/docker.sock
```

Run a container with the latest Ubuntu image and check what version of Ubuntu is using.
```bash
# Docker run takes images to containers (the opposite is docker commit, which takes containers to images)
# -ti or -it stands for interactive terminal
docker run -ti ubuntu:latest bash
root@7c9aa92447b1:/# cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.1 LTS"
root@7c9aa92447b1:/#
exit
```

Whilst running the ubuntu container, open another terminal and list the container information.
Format it so it prints vertically.
```bash
docker ps --format $FORMAT

ID	d108f9799fcb
IMAGE	ubuntu:latest
COMMAND	"bash"
CREATED	About a minute ago
STATUS	Up About a minute
PORTS
NAMES	eloquent_mahavira
```

Check only running containers, all containers and last exited container.
```bash
# only running
docker ps
# all 
docker ps -a
# last exited 
docker ps -l
```

Restart the last exited container to check that a created file is there
```bash
docker ps -l
CONTAINER ID   IMAGE           COMMAND   CREATED         STATUS              PORTS     NAMES
f7fa83213bb3   ubuntu:latest   "bash"    9 minutes ago   Up About a minute             elated_payne

docker start d108f9799fcb
d108f9799fcb

docker exec -it d108f9799fcb bash
root@d108f9799fcb:/# ls
MY-FILE-HERE  bin  boot  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@d108f9799fcb:/#
exit
```

Run an ubuntu container, create a file, then commit the container to create an image that contains the file.
```bash
docker run -ti ubuntu:latest bash
root@c9ae2f8fb6f5:/# touch MY-IMPORTANT-FILE
root@c9ae2f8fb6f5:/# ls
MY-IMPORTANT-FILE  bin  boot  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@c9ae2f8fb6f5:/#
exit

docker ps -l
CONTAINER ID   IMAGE           COMMAND   CREATED          STATUS                     PORTS     NAMES
c9ae2f8fb6f5   ubuntu:latest   "bash"    27 seconds ago   Exited (0) 4 seconds ago             busy_keller

docker commit c9ae2f8fb6f5
sha256:7905ecbec7b86e8bf92e4d6168a7f48790b038d490df56c61e962831497c68d4

docker tag 7905ecbec7b86e8bf92e4d6168a7f48790b038d490df56c61e962831497c68d4 my-image

docker images
REPOSITORY    TAG       IMAGE ID       CREATED              SIZE
my-image      latest    7905ecbec7b8   About a minute ago   77.8MB
ubuntu        latest    cdb68b455a14   32 hours ago         77.8MB
hello-world   latest    feb5d9fea6a5   13 months ago        13.3kB

docker run -ti my-image bash
root@0ace6f5b6547:/# ls
MY-IMPORTANT-FILE  bin  boot  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

# to skip the tag step, just add the name of the image after the container id/name
docker commit c9ae2f8fb6f5 my-image-2
sha256:13e14ed5ed5baddd78c90416e4abeddd731bfd9ab58ae2fbdb12a58b1cd706f2

docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
my-image-2    latest    13e14ed5ed5b   5 seconds ago   77.8MB
my-image      latest    7905ecbec7b8   4 minutes ago   77.8MB
ubuntu        latest    cdb68b455a14   33 hours ago    77.8MB
hello-world   latest    feb5d9fea6a5   13 months ago   13.3kB
```

Run something on the container (sleep for 5 secs) and delete it straight after the container exits.
```bash
docker run --rm -ti ubuntu sleep 5
```

Start a container that runs a bash process which first sleeps for 3s and then prints a message.
```bash
docker run --rm -ti ubuntu bash -c "sleep 3; echo all done"

all done
```

In one terminal run a container in the background, in another terminal attach to it.
```bash
docker run -d -ti ubuntu bash
905f2e1a1d1a9cbe209a92d621437b7ed9b4f7c164b29759794b5a805ad15050

docker ps
CONTAINER ID   IMAGE           COMMAND   CREATED          STATUS          PORTS     NAMES
905f2e1a1d1a   ubuntu          "bash"    13 seconds ago   Up 12 seconds             romantic_vaughan
f7fa83213bb3   ubuntu:latest   "bash"    31 minutes ago   Up 23 minutes             elated_payne
d108f9799fcb   ubuntu:latest   "bash"    37 minutes ago   Up 23 minutes             eloquent_mahavira

docker attach romantic_vaughan
root@905f2e1a1d1a:/# # Use CTL-p CTL-q to detach and leave it running 
```

Run a container with a process that will crash and check the logs to see what went wrong.
```bash
docker run -d -ti --name example ubuntu bash -c "slep 3"
79739550e1f476aa946296fd4ec9f953a22a2599d4101e2830385a8198427191

docker logs example
bash: line 1: slep: command not found
```

Kill and remove all containers (by fetching their IDs).
```bash
docker kill $(docker ps -aq)
docker rm $(docker ps -aq)
```

Search for an image.
```bash
docker search ubuntu
NAME                             DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
ubuntu                           Ubuntu is a Debian-based Linux operating sys…   15132     [OK]
websphere-liberty                WebSphere Liberty multi-architecture images …   290       [OK]
ubuntu-upstart                   DEPRECATED, as is Upstart (find other proces…   112       [OK]
neurodebian                      NeuroDebian provides neuroscience research s…   93        [OK]
ubuntu/nginx                     Nginx, a high-performance reverse proxy & we…   64
open-liberty                     Open Liberty multi-architecture images based…   55        [OK]
ubuntu-debootstrap               DEPRECATED; use "ubuntu" instead                48        [OK]
ubuntu/apache2                   Apache, a secure & extensible open-source HT…   45
ubuntu/squid                     Squid is a caching proxy for the Web. Long-t…   40
ubuntu/mysql                     MySQL open source fast, stable, multi-thread…   38
ubuntu/prometheus                Prometheus is a systems and service monitori…   32
kasmweb/ubuntu-bionic-desktop    Ubuntu productivity desktop for Kasm Workspa…   31
ubuntu/bind9                     BIND 9 is a very flexible, full-featured DNS…   30
ubuntu/postgres                  PostgreSQL is an open source object-relation…   22
ubuntu/redis                     Redis, an open source key-value store. Long-…   15
ubuntu/kafka                     Apache Kafka, a distributed event streaming …   13
ubuntu/prometheus-alertmanager   Alertmanager handles client alerts from Prom…   8
ubuntu/grafana                   Grafana, a feature rich metrics dashboard & …   6
ubuntu/memcached                 Memcached, in-memory keyvalue store for smal…   5
ubuntu/zookeeper                 ZooKeeper maintains configuration informatio…   5
ubuntu/telegraf                  Telegraf collects, processes, aggregates & w…   4
ubuntu/dotnet-deps               Chiselled Ubuntu for self-contained .NET & A…   4
ubuntu/cortex                    Cortex provides storage for Prometheus. Long…   3
ubuntu/cassandra                 Cassandra, an open source NoSQL distributed …   2
ubuntu/loki                      Grafana Loki, a log aggregation system like …   0
```

To test networking and ports knowledge, set up a server and 2 clients that share information.
For this we'll use netcat, a computer networking utility for reading from and writing to network connections using TCP or UDP.
```bash
# in terminal 1
# -p stands for publish, then expose the same port on the inside of the container as on the outside
docker run --rm -ti -p 45678:45678 -p 45679:45679 --name echo-sever ubuntu:14.04 bash
root@679a9adcd331:/# nc -lp 45678 | nc -lp 45679

# in terminal 2
nc localhost 45678

# in terminal 3
nc localhost 45679

# type in both terminals

# instead of having clients listening directly on localhost, we can run them via docker.
# Containers are not allowed to directly address the container by IP address, at least not reliably, so they've added 
# a special host name for containers to refer to the machine that is hosting them. 
# This special name is host.docker.internal.
# You can also use your internal IP address (as the host.docker.internal is not likely to work in Windows)
# in terminal 2
docker run --rm -ti ubuntu:14.04 bash
root@135d839322bf:/# nc host.docker.internal 45678

# in terminal 3
docker run --rm -ti ubuntu:14.04 bash
root@8127514685b8:/# nc host.docker.internal 45679
```

Start a container specifying the internal ports that are exposed but leave the external ports to be dynamically
generated by Docker.
```bash
# in terminal 1
docker run --rm -ti -p 45678 -p 45679 --name echo-sever ubuntu:14.04 bash
root@b859df424a06:/#  nc -lp 45678 | nc -lp 45679

# in terminal 2
docker port echo-sever
45678/tcp -> 0.0.0.0:58836
45679/tcp -> 0.0.0.0:58837

nc localhost 58836

# in terminal 3
nc localhost 58837
```

Create a new network
```bash
# in terminal 1
docker network create learning
b67a0ac79c3862eed86045dbdc0ed09800005d5e182a648ce11633dc5e6da2a8

docker network ls
NETWORK ID     NAME       DRIVER    SCOPE
d658a083a08d   bridge     bridge    local
b8111acec425   host       host      local
b67a0ac79c38   learning   bridge    local
cc27425a7ce5   none       null      local


docker run --rm -ti --network learning --name catserver ubuntu:14.04 bash
root@c03bf926f437:/# ping catserver
PING catserver (172.18.0.2) 56(84) bytes of data.
64 bytes from c03bf926f437 (172.18.0.2): icmp_seq=1 ttl=64 time=0.866 ms
64 bytes from c03bf926f437 (172.18.0.2): icmp_seq=2 ttl=64 time=0.080 ms

# in terminal 2
docker run --rm -ti --network learning --name dogserver ubuntu:14.04 bash
root@51d5ba420118:/# ping dogserver
PING dogserver (172.18.0.3) 56(84) bytes of data.
64 bytes from 51d5ba420118 (172.18.0.3): icmp_seq=1 ttl=64 time=0.079 ms
64 bytes from 51d5ba420118 (172.18.0.3): icmp_seq=2 ttl=64 time=0.210 ms
^C
--- dogserver ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1052ms
rtt min/avg/max/mdev = 0.079/0.144/0.210/0.066 ms
root@51d5ba420118:/# ping catserver
PING catserver (172.18.0.2) 56(84) bytes of data.
64 bytes from catserver.learning (172.18.0.2): icmp_seq=1 ttl=64 time=0.222 ms
64 bytes from catserver.learning (172.18.0.2): icmp_seq=2 ttl=64 time=0.157 ms
^C
--- catserver ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1004ms
rtt min/avg/max/mdev = 0.157/0.189/0.222/0.035 ms
```
