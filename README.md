TYPO3 Docker Images
==========================

[![Build Status](https://travis-ci.org/mecodia/docker-typo3.svg?branch=master)](https://travis-ci.org/mecodia/docker-typo3)
[![Docker Pulls](https://img.shields.io/docker/pulls/mecodia/typo3)](https://hub.docker.com/repository/docker/mecodia/typo3)

This repository contains build instructions for simple TYPO3 Docker images. They might not be production grade!


Build Arguments
---------------

- TYPO3_VERSION: The typo3 version to build this image with, the default builds the latest version 9

Usage
-----

1. See the `docker-compose.yml` as an example for usage of this image. You can just do a `docker-compose up` in here.

2. After that, simply open `http://localhost/` in your browser to start the TYPO3 install tool.

3. To do the installation, you have to create `/var/www/html/FIRST_INSTALL` (e.g. by running `docker-compose exec typo3 touch /var/www/html/FIRST_INSTALL`)

4. Complete the install tool. When prompted for database credentials, use the environment variables that you've passed to the database container. The hostname is the service name of the docker-compose file (so `database`).

Build & Publish
---------------

See the example workflow in `publish.sh`.

Usage:

    ./publish.sh 9.5.16	

