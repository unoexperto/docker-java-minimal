FROM alpine:3.6
MAINTAINER unoexperto <unoexperto.support@mailnull.com>

ENV GLIBC_VERSION=2.27-r0

ARG JAVA_VERSION_MAJOR
ARG JAVA_VERSION_MINOR
ARG JAVA_VERSION_BUILD
ARG JAVA_PACKAGE
ARG JAVA_SHA256_SUM

# installing tools
RUN apk add --update unzip ca-certificates wget

# Set environment
ENV JAVA_HOME /opt/java
ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN mkdir -p ${JAVA_HOME} && \
    rm -R ${JAVA_HOME}

RUN wget -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
  wget -O glibc.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
  apk add glibc.apk && \
  wget -O glibc-bin.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" && \
  apk add glibc-bin.apk && \
  /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
  echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf &&\
  rm -rf glibc.apk glibc-bin.apk /var/cache/apk/*

# Download and unarchive Java
RUN wget --header="Cookie: oraclelicense=accept-securebackup-cookie" -O java.tar.gz\
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz &&\
  echo "$JAVA_SHA256_SUM  java.tar.gz" | sha256sum -c - &&\
  gunzip -c java.tar.gz | tar -xf - -C /opt && rm -f java.tar.gz &&\
  ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} ${JAVA_HOME} &&\
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

# installing JCE
RUN cd ${JAVA_HOME}/jre/lib/security &&\
    wget --header="Cookie: oraclelicense=accept-securebackup-cookie" -O jce_policy-8.zip http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip &&\
    unzip -o -j jce_policy-8.zip UnlimitedJCEPolicyJDK8/*.jar &&\
    rm -f jce_policy-8.zip

# remove toold
RUN apk del unzip wget ca-certificates
