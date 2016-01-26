# AlpineLinux 3.3 with a glibc-2.21 and Oracle JDK9
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

# set JDK version
ENV JAVA_VERSION_MAJOR 9
ENV JAVA_VERSION_MINOR ea
ENV JAVA_VERSION_BUILD 101
ENV JAVA_PACKAGE       jdk

# Download and unarchive Java
RUN mkdir /opt && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://www.java.net/download/${JAVA_PACKAGE}${JAVA_VERSION_MAJOR}/archive/${JAVA_VERSION_BUILD}/binaries/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}-${JAVA_VERSION_MINOR}+${JAVA_VERSION_BUILD}_linux-x64_bin.tar.gz \
    | tar -xzf - -C /opt

# Set environment
ENV JAVA_HOME /opt/jdk-9
ENV PATH ${PATH}:${JAVA_HOME}/bin