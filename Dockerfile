FROM bitnami/minideb:stretch
MAINTAINER unoexperto <unoexperto.support@mailnull.com>

ENV JAVA_VERSION=12
ENV JAVA_VERSION_BUILD=33
ENV JAVA_PACKAGE=jdk
ENV JAVA_SHA256_SUM=183d4d897bbf47bdae43b2bb4fc0465a9178209b5250555ac7fdb8fab6cc43a6
ENV JAVA_PATH_HASH=312335d836a34c7c8bba9d963e26dc23

# Set environment
ENV JAVA_HOME /opt/java
ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN apt-get update && \
    apt-get install -y wget

RUN mkdir -p ${JAVA_HOME} && rm -R ${JAVA_HOME}

# Download and unarchive Java
RUN cd \tmp && \
    wget -nv --header="Cookie: oraclelicense=accept-securebackup-cookie" -O java.tar.gz \
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}+${JAVA_VERSION_BUILD}/${JAVA_PATH_HASH}/${JAVA_PACKAGE}-${JAVA_VERSION}_linux-x64_bin.tar.gz &&\
    echo "$JAVA_SHA256_SUM  java.tar.gz" | sha256sum -c - &&\
    gunzip -c java.tar.gz | tar -xf - -C /opt && rm -f java.tar.gz &&\
    ln -s /opt/jdk-${JAVA_VERSION} ${JAVA_HOME} &&\
    rm -rf ${JAVA_HOME}/*src.zip \
        ${JAVA_HOME}/lib/missioncontrol \
        ${JAVA_HOME}/lib/visualvm \
        ${JAVA_HOME}/lib/*javafx* \
        ${JAVA_HOME}/jre/lib/plugin.jar \
        ${JAVA_HOME}/jre/lib/ext/jfxrt.jar \
        ${JAVA_HOME}/jre/bin/javaws \
        ${JAVA_HOME}/jre/lib/javaws.jar \
        ${JAVA_HOME}/jre/lib/desktop \
        ${JAVA_HOME}/jre/plugin \
        ${JAVA_HOME}/jre/lib/deploy* \
        ${JAVA_HOME}/jre/lib/*javafx* \
        ${JAVA_HOME}/jre/lib/*jfx* \
        ${JAVA_HOME}/jre/lib/amd64/libdecora_sse.so \
        ${JAVA_HOME}/jre/lib/amd64/libprism_*.so \
        ${JAVA_HOME}/jre/lib/amd64/libfxplugins.so \
        ${JAVA_HOME}/jre/lib/amd64/libglass.so \
        ${JAVA_HOME}/jre/lib/amd64/libgstreamer-lite.so \
        ${JAVA_HOME}/jre/lib/amd64/libjavafx*.so \
        ${JAVA_HOME}/jre/lib/amd64/libjfx*.so

RUN apt-get remove -y wget

RUN rm -rf /var/cache/apt/*
