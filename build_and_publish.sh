#!/usr/bin/env bash

docker login

docker build -t expert/docker-java-minimal:jdk16-alpine .
docker push expert/docker-java-minimal:jdk16-alpine

docker logout
