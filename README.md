## Minimal Docker image with Java 8 and installed Java Cryptography Extension (JCE)

[Docker](https://www.docker.com/) image to run [Java](https://www.java.com/) applications.
This is based off [Alpine](https://registry.hub.docker.com/_/alpine/) to keep the size minimal (67 MB).

GitHub Project: https://github.com/unoexperto/docker-java-minimal

### Usage

To test: 

    docker run -it --rm expert/docker-java-minimal:latest java -version
    
Or can be used as parent image for deployment of Java servers (akka in my case) in docker using https://github.com/sbt/sbt-native-packager