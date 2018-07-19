#!/usr/bin/env bash

docker login

docker build -t expert/docker-java-minimal:jdk10 .
docker push expert/docker-java-minimal:jdk10

docker logout