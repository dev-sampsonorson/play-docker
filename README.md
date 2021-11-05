# Play /w Docker

### Installation & tooling

Memorize the command; `docker ps`

###### Install Docker

    - [Docker Desktop](https://www.docker.com/products/docker-desktop)
    - [Docker for Mac](https://www.docker.com/products/docker-for-mac)
    - [Docker for Windows](https://www.docker.com/products/docker-for-windows)
    - [Docker for Linux](https://www.docker.com/products/docker-for-linux)

###### Docker for VS Code

This will give you language support when you write you docker files. This 
will also link up to remote registries.

    - [Docker for VS Code](https://marketplace.visualstudio.com/items?itemName=Docker.vscode)

### Create Dockerfile

Every instruction in the Dockerfile is its own step or layer.

Too keep thing efficient docker will cache layers 
if nothing has changed

Normally if working on a node project,
you get your source code then install dependencies
In docker, you want to install your dependencies first
so that they can be cached. We don't want to 
reinstall all our node modules anytime we
change our app source code

### Build docker image

You buid a docker image by running the command;

`docker build -t tebodocker2017/demoapp:1.0 .`

The command above will build a docker image named `tebodocker2017/demoapp:1.0` from the current directory.

### Push docker image

After the image is built, 
    - you can use it as a base image to create other images
    - or use it to run a container

In real life, to use the image you would mostly likely push it to a container registry;
    - Docker Hub
    - Or your favorite cloud provider

You use the `docker push` command to push the image to a registry.

### Run container

The command below will run a container from the image; basically create 
a running process called the container.

`docker run tebodocker2017/demoapp:1.0`

If you run the above command, it should say:

`Listening on port 8080`

If you go to the browser and visit the address `http://localhost:8080`, you
don't see anything. The question now is why can't I access my container
locally?

We exposed the port `8080`, but by default it's not accessible to the 
outside world.

Let's refactor our command, to use the `-p` flat to implement port forwarding 
from the docker container to the local/host maching.

`docker run -p 5000:8080 tebodocker2017/demoapp:1.0`

We will be mapping the port `5000` on our local maching to the port `8080` 
on the container.

`local:container`

**Note**

One thing to keep in mind is that the docke container will still be running
even after you close the terminal window.

If you stop the container, any state or data you created inside of it
will be lost.

### Sharing data between containers

The preferred way to share data between containers is to use volumes.

A **Volume** is a dedicated directory on the host machine. Inside this
directory, a container can create files and directories that can be 
remounted into future containers or multiple containers at the same time.

To create a volume we use the following command;

`docker volume create shared-stuff`
`docker volume create --name shared-stuff`

After the volume is created, we can mount it somewhere in our contianer
when we run it;

`docker run \
    --mount source=shared-stuff,target=/stuff`

Multiple contianers can mount this volume simultaneously and access the 
same set of files. The files stick around after the containers are shut down.

### Debugging

When things don't go as planned, you might want to;

- inspect the logs
- access the terminal inside the container

With docker desktop, on clicking on the running container, you can see all
the logs and also search through them.

You can also execute commands inside the container by clicking on the 
`cli` button. You can also do the same from your own terminal by using the
command;

`docker exec -it ef89106a5b20 bash`

This command puts us at the root of the file system of that container.

You can use `docker ps` to get the container id.

### Tips

1. Process per container

To keep you containers healthy, you should write simple maintainable 
microservices. Each container should only run one process. If you need multiple
processes, then you should create multiple containers. Docker has a tool for
running multiple containers at the same time.

### Docker Compose

Docker Compose is a tool for running multiple containers at the same time.

We already have a node app, but let's imagine that our node app needs to access
a MySql database. We will also likely want a volume to persist the database 
across multiple containers.

All these can be managed with Docker Compose. We need to create a 
`docker-compose.yml` file at the root of our project.

Once the configuration has been set in the `docker-compose.yml` file, we can run;
`docker-compose up`

We shut down all our containers together with;
`docker-compose down`