#!/bin/sh
REPO_VERSION=$(git describe --always --tags)
TYPO3_VERSION=$1
PHP_VERSION=7.4-apache-buster
echo "Building mecodia/typo3 $REPO_VERSION with typo3 v$TYPO3_VERSION on $PHP_VERSION"
echo " - Pulling base image"
docker pull php:$PHP_VERSION
echo " - Building typo3 image"
docker build . --build-arg PHP_VERSION=$PHP_VERSION --build-arg TYPO_VERSION=$TYPO3_VERSION --build-arg BUILD_VERSION=$REPO_VERSION -t mecodia/typo3:$TYPO3_VERSION-$REPO_VERSION -t mecodia/typo3:$TYPO3_VERSION-latest
echo " - Pushing with tag $TYPO3_VERSION-$REPO_VERSION"
docker push mecodia/typo3:$TYPO3_VERSION-$REPO_VERSION
echo " - Pushing with tag $TYPO3_VERSION-latest"
docker push mecodia/typo3:$TYPO3_VERSION-latest
