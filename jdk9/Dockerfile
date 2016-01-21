# Ubuntu with Oracle Java 9
FROM ubuntu:latest
MAINTAINER Greg Maslowski gregmaslowski@gmail.com

# Install curl
RUN apt-get install curl -y

# Java Version
ENV JAVA_VERSION_MAJOR 9
ENV JAVA_VERSION_MINOR ea
ENV JAVA_VERSION_BUILD 101
ENV JAVA_PACKAGE       jdk


# Download and unarchive Java
# RUN mkdir /opt &&
RUN curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie"\
  http://www.java.net/download/${JAVA_PACKAGE}${JAVA_VERSION_MAJOR}/archive/${JAVA_VERSION_BUILD}/binaries/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}-${JAVA_VERSION_MINOR}+${JAVA_VERSION_BUILD}_linux-x64_bin.tar.gz \
    | tar -xzf - -C /opt

# Set environment
ENV JAVA_HOME /opt/jdk-9
ENV PATH ${PATH}:${JAVA_HOME}/bin
