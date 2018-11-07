#!/usr/bin/env bash

docker login

docker build -t expert/docker-java-minimal:jdk11 .
docker push expert/docker-java-minimal:jdk11

docker logout