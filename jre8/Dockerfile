# AlpineLinux 3.3 with a glibc-2.21 and Oracle JRE8
FROM alpine:3.3
MAINTAINER Greg Maslowski gregmaslowski@gmail.com

# https://github.com/gliderlabs/docker-alpine/issues/11:
# install glibc
# hotfix /etc/nsswitch.conf
RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates && \
    export ALPINE_GLIBC_BASE_URL="https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64" && \
    export ALPINE_GLIBC_PACKAGE="glibc-2.21-r2.apk" && \
    export ALPINE_GLIBC_BIN_PACKAGE="glibc-bin-2.21-r2.apk" && \
    wget "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE" "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_BIN_PACKAGE" && \
    apk add --no-cache --allow-untrusted "$ALPINE_GLIBC_PACKAGE" "$ALPINE_GLIBC_BIN_PACKAGE" && \
    /usr/glibc/usr/bin/ldconfig "/lib" "/usr/glibc/usr/lib" && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    apk del build-dependencies && \
    rm "$ALPINE_GLIBC_PACKAGE" "$ALPINE_GLIBC_BIN_PACKAGE"

# install curl, tar, ca-certificates
RUN apk --update add curl ca-certificates tar

# Java Version
ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 73
ENV JAVA_VERSION_BUILD 02
ENV JAVA_PACKAGE       jre

# Download and unarchive Java
RUN mkdir /opt && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie"\
  http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    | tar -xzf - -C /opt &&\
    ln -s /opt/${JAVA_PACKAGE}1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jre &&\
    rm -rf /opt/jre/lib/plugin.jar \
               /opt/jre/lib/ext/jfxrt.jar \
               /opt/jre/bin/javaws \
               /opt/jre/lib/javaws.jar \
               /opt/jre/lib/desktop \
               /opt/jre/plugin \
               /opt/jre/lib/deploy* \
               /opt/jre/lib/*javafx* \
               /opt/jre/lib/*jfx* \
               /opt/jre/lib/amd64/libdecora_sse.so \
               /opt/jre/lib/amd64/libprism_*.so \
               /opt/jre/lib/amd64/libfxplugins.so \
               /opt/jre/lib/amd64/libglass.so \
               /opt/jre/lib/amd64/libgstreamer-lite.so \
               /opt/jre/lib/amd64/libjavafx*.so \
               /opt/jre/lib/amd64/libjfx*.so

# Clean up
RUN apk del curl ca-certificates tar

# Set environment
ENV JAVA_HOME /opt/jre
ENV PATH ${PATH}:${JAVA_HOME}/bin
