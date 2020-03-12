TYPO3 Docker Images
==========================

This repository contains build instructions for a simple TYPO3 Docker image.

Arguments
---------

- TYPO3_VERSION: The typo3 version to download on build.

Usage
-----

1. See the `docker-compose.yml` as an example for usage of this image. You can just do a `docker-compose up` in here.

2. After that, simply open `http://localhost/` in your browser to start the TYPO3 install tool.

3. To do the installation, you have to create `/var/www/html/FIRST_INSTALL` (e.g. by running `docker-compose exec typo3 touch /var/www/html/FIRST_INSTALL`)

4. Complete the install tool. When prompted for database credentials, use the environment variables that you've passed to the database container. The hostname is the service name of the docker-compose file (so `database`).

Build & publish
---------------

Example:

    docker build . --build-arg TYPO_VERSION=9.5.14 -t mecodia/typo3:9.5.14
    docker push mecodia/typo3:9.5.14
