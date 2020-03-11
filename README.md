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

3. Complete the install tool. When prompted for database credentials, use the environment variables that you've passed to the database container. The hostname is the service name of the docker-compose file (so `database`).

Available tags
--------------

This repository offers the following image tags:

- `latest` maps to the latest available LTS version
- `10` and `10` for the latest available version from the `10.*` branch. 
- `9` for the latest available version from the `9.*` branch.
- `8` for the latest available version from the `8.*` branch.
