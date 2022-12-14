[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE.md)

# Learning Docker

* [Description](#description)
* [Objectives](#objectives)
* [Local setup](#local-setup)
* [License](#license)

## Description
https://www.linkedin.com/learning/learning-docker-2018/

Follow course to know more about Docker.

## Objectives
- Installing Docker on Mac, Windows, and Linux
- Understanding the Docker flow
- Running processes in containers
- Managing, networking, and linking containers
- Working with Docker images, volumes, and registries
- Building Dockerfiles
- Managing networking and namespaces with Docker
- Building entire systems with Docker

## Local setup
- Install Docker https://docs.docker.com/get-docker/
- Run the following script to add an environment variable that will format nicely the output of the Docker commands:
```bash
source ./exercise_files/reformat.sh
### check the variable was set correctly 
echo $FORMAT 
```
- Run the following command to make sure the Docker installation was good:
```bash
docker run hello-world
# should print some info about Docker, including something like: 
# "Hello from Docker!
# This message shows that your installation appears to be working correctly." 
```

## License
This project is licensed under the terms of the MIT License.
Please see [LICENSE](LICENSE.md) for details.
