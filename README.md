# Container for R Applications

In this project we keep our configuration for INWT projects. If you are not working with us you can
see what we think is a good way to bring R applications into production. If you need a clean docker
container for your own application you do _not_ start from here: go to
https://hub.docker.com/u/rocker/ which is also the place from where we started. And should anybody
of you read this: Thank you so much! Great work!

The container from this project can be found at:

-   https://hub.docker.com/u/inwt/
-   https://github.com/INWTlab/r-docker

## Featured images

### r-base

-   Starts from rocker/r-ver:4.1.2
-   Includes basic build tools
-   Adds INWT network settings: certificate and r-repo

### r-batch

-   Starts from r-base
-   Adds database connectors (MySQL)
-   Basic packages for modelling (lme4, mgcv, gbm)
-   Packages for data manipulation (data.table, dplyr, tidyr)
-   Home-brewed and open source (dbtools, mctools)

### r-geos

-   Starts from r-batch
-   Installs Linux libraries necessary for running geo/gis related operations.
-   Adds geo/gis related packages (sf, stars, terra, etc.)

### r-shiny

-   Starts from r-batch
-   Adds shiny related packages (shiny, shinyjs, etc.)

### r-ver-ubuntu (deprecated)

-   Based on Ubuntu
-   R in given version with fixed MRAN
-   Based on the rocker r-ver project

## Why using docker

R is great but it lacks a deployment model. When you use Java, you have the JVM to abstract away the
operating system you want to run your applications on. This means you write your application,
compile it to a distributable unit (jar), and run it on any operating system that supports the JVM
(every relevant flavour of OS does). And we want this type of distribution model. One, executable
and testable unit which we can ship to our customers or distribute across our own machines; just for
R.

Make no mistake: R is stable, runs on basically any OS, and we have been happily using it for years,
without docker. Also in production. However our experience with the particular pick of OS and
possibly restrictive versioning of our clients IT support made us realise, that the world is a
better place when we control the run-time environment of our applications.

This is the desired mode for production. It means we can save an image. Distribute it to a
node/agent. Load it there. And execute it in that environment.

Once the image has been built, the application is said to be _static_, in that it will not pull any
updates or is reacting to any changes (like code-bases or packages).

It is also _state-less_: assume that every container instance is deleted in the very moment it
completes a single run. This means a container is deleted whenever a user session of a shiny
application ends or an analyses is completed. Each run should be completely independent and should
never save any data _inside_ the container.

## How to: Dockerfile & .dockerignore

### Dockerfile

Docker images are build based on so called `Dockerfile`s. These files contain all the commands to be
applied during the build process. Most importantly, we will not build images from scratch but rather
make use of the predefined images introduced above. Therefore, a possible Dockerfile might contain
the following code:

```
FROM inwt/r-batch:3.4.4

ADD . .
RUN rm -vf .Rprofile && \
  installPackage

CMD ["Rscript", "inst/R_Code/someScript.R"]
```

Here, `FROM` refers to the predefined image. `ADD` copies files and directories onto the filesystem
of the image. `RUN` simply executes the following commands (here: removing the `.Rprofile` file and
installing the R package (this is a predefined function). Finally, `CMD` is used to provide default
behavior for the container (here, a script is called via `Rscript`). We remove `.Rprofile` because
it may override the CRAN repositories pre-configured inside the container as well as library paths.

There are, of course, a lot more options avaialble. A reference can be found
[here](https://docs.docker.com/engine/reference/builder/). More importantly try to understand and
read the
[best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).

### .dockerignore

A `.dockerignore` is used to explicitly exclude all files not necessary for the build, very similar
to `.Rbuildignore` or `.gitignore` files. The very first thing in a docker build is that the _build
context_ is copied into the image. This context should be as small as possible because it is carried
around a lot. See the
[documentation on .dockerignore](https://docs.docker.com/engine/reference/builder/).

```
lib*
deps
largeFile.csv
```

### docker build and run

Two things we need to do to start and work with a container:

-   build the image
-   unsurprisingly start the container

The following turned out to be a good default for local development:

```
docker build --pull -t tmp <path/to/Dockerfile> && docker run --rm -it --network host tmp
```

So in a bit more detail:

```
docker build \
    --pull \               # tries to pull new versions of the image in 'FROM'
    -t tmp \               # the image gets the 'tag': 'tmp'
    <path/to/Dockerfile> \ # e.g. '.'
  && docker run \
    --rm \                 # remove container when run is completed
    -it \                  # interactive session, i.e. that we can stay in a console
    --network host \       # so that the process has the same IP as the host
    tmp                    # the name of the image -- reference to the 'tag'
```

These commands will build and then try to execute the command defined in the `CMD` in your
`Dockerfile`.

### quick reference

```
docker ps                                # display all running container
docker logs <container>                  # show output of a container
docker attach <container>                # attach to a running container
docker run -it --rm <image> bash         # start a bash inside a container to figure out what
                                         # the hell is going on! Most usefull when it just
                                         # doesn't build.
docker exec -i -t <container> /bin/bash  # open a new terminal running bash
                                         # inside an already running container
```

## Use cases

### Run shiny applications

```
docker build -t example-app ./examples/app
docker run --rm -p 3838:3838 example-app
docker run --rm --network host example-app
```

### Run R-jobs in batch mode

```
docker build -t example-batch ./examples/batch
docker run --rm example-batch
docker run --rm example-batch Rscript main.R
docker run --rm example-batch Rscript main.R arg1 arg2
```

### Debug applications in production

### Run tests and r-cmd-check against different environments and package versions

This does not require a local Dockerfile (that would be more stable though). Here we can use a
container as a runtime evironment and just execute it to run `R CMD check .`. With `-v` you mount a
directory (volume) to the container. `$PWD` is where you are right now, and `/app` is the home
directory of the container. Be aware that with `-v` we are granting write access!

```
cd /path/to/your/package
docker run --rm -v $PWD:/app --user `id -u`:`id -g` inwt/r-batch:3.4.4 check
docker run --rm -v $PWD:/app --user `id -u`:`id -g` inwt/r-batch:3.5.1 check
```
