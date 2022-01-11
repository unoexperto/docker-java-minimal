## Minimal Docker images with Java 8 (+ Java Cryptography Extension [JCE]) and Java 10 

[Docker](https://www.docker.com/) image to run [Java](https://www.java.com/) applications.
This is based off [Alpine](https://registry.hub.docker.com/_/alpine/) to keep the size minimal (~65 MB).

GitHub Project: https://github.com/unoexperto/docker-java-minimal

### Versions

Different versions are located in separate branches to allow automated build on Docker Hub.

- server-jre8
- server-jre10
- jdk8
- jdk10
- master - defaults to Java 8 and is no longer published to Docker Hub

### If you want to build it locally

To test: 

    docker run -it --rm expert/docker-java-minimal:latest java -version
    
Or can be used as parent image for deployment of Java servers (akka in my case) in docker using https://github.com/sbt/sbt-native-packager