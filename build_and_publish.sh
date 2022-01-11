#!/usr/bin/env bash

docker login

docker build -t bitparticles/base:jdk16-alpine3.15.0 .
docker push bitparticles/base:jdk16-alpine3.15.0 

docker logout
