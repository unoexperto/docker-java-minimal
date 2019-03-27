#!/usr/bin/env bash

docker login

docker build -t expert/docker-java-minimal:jdk12-ubuntu .
docker push expert/docker-java-minimal:jdk12-ubuntu

docker logout