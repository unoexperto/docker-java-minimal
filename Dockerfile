FROM alpine:latest
MAINTAINER unoexperto <unoexperto.support@mailnull.com>

ENV GLIBC_VERSION=2.33-r0

ENV JAVA_VERSION=15.0.2
ENV JAVA_VERSION_BUILD=7
ENV JAVA_PACKAGE=jdk
ENV JAVA_SHA256_SUM=54b29a3756671fcb4b6116931e03e86645632ec39361bc16ad1aaa67332c7c61 
ENV JAVA_PATH_HASH=0d1cfde4252546c6931946de8db48ee2

# installing tools
RUN apk add --update unzip ca-certificates wget

# Set environment
ENV JAVA_HOME /opt/java
ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN mkdir -p ${JAVA_HOME} && \
    rm -R ${JAVA_HOME}

RUN apk --update add --no-cache ca-certificates curl openssl binutils tar xz zstd \
    && ALPINE_GLIBC_REPO="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" \
    && curl -Ls ${ALPINE_GLIBC_REPO}/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk > /tmp/${GLIBC_VERSION}.apk \
    && apk add --allow-untrusted /tmp/${GLIBC_VERSION}.apk \
    && curl -Ls ${ALPINE_GLIBC_REPO}/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk > /tmp/${GLIBC_VERSION}-bin.apk \
    && rm /usr/glibc-compat/lib/ld-linux-x86-64.so.2 \
    && ln -s /usr/glibc-compat/lib/ld-2.31.so /usr/glibc-compat/lib/ld-linux-x86-64.so.2 \
    && apk add --allow-untrusted /tmp/${GLIBC_VERSION}-bin.apk \
    && curl -Ls https://www.archlinux.org/packages/core/x86_64/gcc-libs/download > /tmp/gcc-libs.tar.xz \
    && mkdir /tmp/gcc \
    && tar -xf /tmp/gcc-libs.tar.xz -C /tmp/gcc \
    && mv /tmp/gcc/usr/lib/libgcc* /tmp/gcc/usr/lib/libstdc++* /usr/glibc-compat/lib \
    && strip /usr/glibc-compat/lib/libgcc_s.so.* /usr/glibc-compat/lib/libstdc++.so* \
    && curl -Ls https://www.archlinux.org/packages/core/x86_64/zlib/download > /tmp/libz.tar.zst \
    && mkdir /tmp/libz \
    && tar -xf /tmp/libz.tar.zst -C /tmp/libz \
    && mv /tmp/libz/usr/lib/libz.so* /usr/glibc-compat/lib \
    && apk del binutils zstd \
    && rm -rf /tmp/${GLIBC_VERSION}.apk /tmp/${GLIBC_VERSION}-bin.apk /tmp/gcc /tmp/gcc-libs.tar.xz /tmp/libz /tmp/libz.tar.zst /var/cache/apk/* \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

# Download and unarchive Java
RUN wget --header="Cookie: oraclelicense=accept-securebackup-cookie" -O java.tar.gz\
    https://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}+${JAVA_VERSION_BUILD}/${JAVA_PATH_HASH}/${JAVA_PACKAGE}-${JAVA_VERSION}_linux-x64_bin.tar.gz &&\
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
         ${JAVA_HOME}/jre/lib/amd64/libjfx*.so &&\
  rm -rf /var/cache/apk/*

# remove tools
RUN apk del unzip wget ca-certificates
