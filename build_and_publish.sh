#!/usr/bin/env bash

docker login

docker build -t expert/docker-java-minimal:server-jre8 .
docker push expert/docker-java-minimal:server-jre8

docker logout