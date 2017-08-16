#!/bin/bash

export JDK_VERSION_MINOR=`grep -q "ENV JAVA_VERSION_MINOR" jdk8/Dockerfile | awk '{print $3}'`
export JRE_VERSION_MINOR=`grep -q "ENV JAVA_VERSION_MINOR" jre8/Dockerfile | awk '{print $3}'`

docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS

docker tag $TAG_JDK gmaslowski/jdk:8
docker tag $TAG_JDK gmaslowski/jdk:8u$JDK_VERSION_MINOR
docker tag $TAG_JDK gmaslowski/jdk:latest

docker push gmaslowski/jdk:8
docker push gmaslowski/jdk:8u$JDK_VERSION_MINOR
docker push gmaslowski/jdk:latest

docker tag $TAG_JRE gmaslowski/jre:8
docker tag $TAG_JRE gmaslowski/jre:8u$JRE_VERSION_MINOR
docker tag $TAG_JRE gmaslowski/jre:latest

docker push gmaslowski/jre:8
docker push gmaslowski/jre:8u$JRE_VERSION_MINOR
docker push gmaslowski/jre:latest
