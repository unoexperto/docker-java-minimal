#!/usr/bin/env bash

docker login

docker build --build-arg JAVA_VERSION_MAJOR=8 JAVA_VERSION_MINOR=112 JAVA_VERSION_BUILD=15 JAVA_PACKAGE=server-jre JAVA_SHA256_SUM=eb51dc02c1607be94249dc28b0223be3712b618ef72f48d3e2bfd2645db8b91a -t expert/docker-java-minimal:server-jre .
docker push expert/docker-java-minimal:server-jre

docker build --build-arg JAVA_VERSION_MAJOR=8 JAVA_VERSION_MINOR=112 JAVA_VERSION_BUILD=15 JAVA_PACKAGE=jdk JAVA_SHA256_SUM=777bd7d5268408a5a94f5e366c2e43e720c6ce4fe8c59d9a71e2961e50d774a5 -t expert/docker-java-minimal:jdk .
docker push expert/docker-java-minimal:jdk

docker logout