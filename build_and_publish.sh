#!/usr/bin/env bash

docker login

docker build -t expert/docker-java-minimal:jdk .
docker push expert/docker-java-minimal:jdk8

docker logout