# Container for R Applications

In this project we keep our configuration for INWT projects. If you are not
working with us you can see what we think is a good way to
bring R applications into production. If you need a clean docker container for
your own application you do *not* start from here: go to
https://hub.docker.com/u/rocker/ which is also the place from where we started.
And should anybody of you read this: Thank you so much! Great work!

The container from this project can be found at: 

- https://hub.docker.com/u/inwt/
- https://github.com/INWTlab/r-docker


## Featured images

### r-ver-ubuntu

- Based on Ubuntu
- R in given version
- Based on the rocker r-ver project

### r-base

- Starts from r-ver-ubuntu
- Includes basic build tools
- Adds INWT network settings: certificate and r-repo

### r-batch

- Starts from r-base
- Adds database connectors (MySQL)
- Basic packages for modelling (lme4, mgcv, gbm)
- Packages for data manipulation (data.table, dplyr, tidyr)
- Home-brewed and open source (dbtools, mctools)

### r-shiny

- Starts from r-batch
- Adds shiny related packages (shiny, shinyjs, etc.)


## Why using docker

R is great but it lacks a deployment model. When you use Java, you have the JVM
to abstract away the operating system you want to run your applications on. This
means you write your application, compile it to a distributable unit (jar), and
run it on any operating system that supports the JVM (every relevant flavour of
OS does). And we want this type of distribution model. One, executable and
testable unit which we can ship to our customers or distribute across our own
machines; just for R.

Make no mistake: R is stable, runs on basically any OS, and we have been happily
using it for years, without docker. Also in production. However our experience
with the particular pick of OS and possibly restrictive versioning of our
clients IT support made us realise, that the world is a better place when we
control the run-time environment of our applications.

This is the desired mode for production. It means we can save an image.
Distribute it to a node/agent. Load it there. And execute it in that
environment.

Once the image has been built, the application is said to be *static*, in that
it will not pull any updates or is reacting to any changes (like code-bases or
packages).

It is also *state-less*: assume that every container instance is deleted in the
very moment it completes a single run. This means a container is deleted
whenever a user session of a shiny application ends or an analyses is completed.
Each run should be completely independent and should never save any data *inside*
the container.

## How to: Dockerfile & .dockerignore

### Dockerfile

Docker images are build based on so called `Dockerfile`s. These files contain all 
the commands to be applied during the build process. Most importantly, we will not 
build images from scratch but rather make use of the predefined images introduced
above. Therefore, a possible Dockerfile might contain the following code:

```
FROM inwt/r-batch:3.4.4

ADD . .
RUN rm -v .Rprofile && \
  installPackage

CMD ["Rscript", "inst/R_Code/someScript.R"]
```

Here, `FROM` refers to the predefined image. `ADD` copies files and directories onto
the filesystem of the image. `RUN` simply executes the following commands (here:
removing the .Rprofile file and installing the R package (this is a predefined 
function). Finally, `CMD` is used to provide default behavior for the container
(here, a script is called via Rscript).

There are, of course, a lot more options avaialble. A reference can be found [here](
https://docs.docker.com/engine/reference/builder/)

### .dockerignore

A .dockerignore is used to explicitly exclude all files not necessary for the build, 
very similar to .Rbuildignore or .gitignore files.

## Use cases

### Run shiny applications

### Run R-jobs in batch mode

### Debug applications in production

### Run tests and r-cmd-check against different environments and package versions

### Reports

