#!/bin/sh
echo "Building mecodia/typo3 with typo3 version $1"
echo " - Pulling base image"
docker pull php:7.4-apache-buster
echo " - Building typo3 image"
docker build . --build-arg TYPO_VERSION=$1 -t mecodia/typo3:$1
echo " - Pushing with tag=$1"
docker push mecodia/typo3:$1
echo " - Pushing with tag=latest"
docker push mecodia/typo3:latest
