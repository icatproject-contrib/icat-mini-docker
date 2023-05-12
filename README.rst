icat-mini-docker - A minimal ICAT deployment with Docker
========================================================

This repository aims to provide a runtime environment to deploy an
`ICAT`_ service using Docker containers.  The aim is to keep that as
simple as possible, yet still to provide a complete running
deployment.  The main goal is to demonstrate how the ICAT Docker
container are supposed to be used.  At the same time it may be used as
a starting point to build a real production environment.

Quickstart
~~~~~~~~~~

Clone the repository and run `make`::

  $ git clone git@github.com:icatproject-contrib/icat-mini-docker.git
  $ cd icat-mini-docker
  $ make

This should start two container, a MariaDB database and ICAT.  It
takes a moment to start, you may want to check the log with::

  $ sudo docker-compose logs -f

An output line reading ``GlassFish is running`` indicates that ICAT is
up (unless you got an error message earlier in the output).


.. _ICAT: https://icatproject.org/
