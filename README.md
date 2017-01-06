# docker-android

This is a base image, used for our GitLab CI as a shared runner. Packages
are included to build our Android libraries and apps.

## Build local image

```bash
$ docker build -t hhucn-android .
```

This takes a while, since all packages from the Dockerfile need to be installed.

## Start local instance of the container

Connect to local container with a bash:

```bash
$ docker run -it hhucn-android bash
```

## Copy files to the running container

Assuming you connected to the container you previously built and started a bash
with:

```bash
$ docker run -it hhucn-android bash
root@ac9e1dfa2eecy:/#
```

In this example, the host is `ac9e1dfa2eec`. We can now copy files from our host
into this container. For example we want to copy the file `foo.md` into our
container. Then we have to call from our *host* system:

```bash
$ docker cp foo.md ac9e1dfa2eec:/foo.md
```

Inside the container, we can see the file:

```bash
root@ac9e1dfa2eecy:/ ls -l foo.md
-rw-r--r-- 1 root root 4 Jun 21 13:04 foo.md
```
