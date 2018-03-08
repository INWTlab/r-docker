# Container for R Applications

In this project we keep our configuration for INWT projects. If you are not
working with us you can see what we think is a good way to
bring R applications into production. If you need a clean docker container for
your own application you do *not* start from here: go to
https://hub.docker.com/u/rocker/ which is also the place from where we started.
And should anybody of you read this: Thank you so much! Great work!

The container from this project can be found at: 

- https://hub.docker.com/u/inwt/
- github

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

### Two running modes

#### As standalone application inside a container

This is the desired mode for production. It means we can save an image. Copy it
to a node/agent. Load it there. And execute it in that environment.

Once the image has been built, the application is said to be *static*, in that
it will not pull any updates or is reacting to any changes (like code-bases or
packages).

It is also *state-less*: assume that every container instance is deleted in the
very moment it completes a single run. This means a container is deleted
whenever a user session of a shiny application ends or an analyses is completed.
Each run should be completely independent and should never save any data *inside*
the container.

In this mode you have to write a *Dockerfile* for your project. In `./templates`
you find examples from where you can begin. They all build up on this project.

#### As portable run-time environment

For debugging purposes and running tests it can be helpful to **plug** a script
or folder into a container **and** hit **play**. This means we try to infer as
much information as possible and *make it happen* without writing a *Dockerfile*.

As tempting as *plug-and-play* may sound it is no stable deployment model. The
reason for this is that we separate the run-time environment from the
application. And we want a stable run-time combined with a snapshot of our
application as deployable unit. This is the reason for using docker, remember?

## Use cases

### Run shiny applications

### Run R-jobs in batch mode

### Debug applications in production

### Run tests and r-cmd-check against different environments and package versions

