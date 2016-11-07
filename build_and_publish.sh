#!/usr/bin/env bash
./build.sh --local-name=docker-java-minimal --image-name=docker-java-minimal --image-owner=expert --image-tags=latest
./publish.sh --local-name=docker-java-minimal --image-name=docker-java-minimal --image-owner=expert --image-tags=latest