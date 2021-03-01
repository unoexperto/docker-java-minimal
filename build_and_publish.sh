#!/usr/bin/env bash

docker login

docker build -t expert/docker-java-minimal:jdk15-alpine .
docker push expert/docker-java-minimal:jdk14-alpine

docker logout