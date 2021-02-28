FROM jenkins/jenkins:lts-jdk11

USER root

ENV DOCKERVERSION=20.10.4
ENV DOCKER_HOME=/opt/docker
RUN mkdir -p ${DOCKER_HOME}/bin
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 -C ${DOCKER_HOME}/bin && rm docker-${DOCKERVERSION}.tgz
ENV PATH=$DOCKER_HOME/bin:$PATH

ENV MAVENVERSION=3.6.3
ENV MAVEN_HOME=/opt/maven
RUN mkdir -p ${MAVEN_HOME}/bin
RUN curl -fsSLO https://pub.tutosfaciles48.fr/mirrors/apache/maven/maven-3/${MAVENVERSION}/binaries/apache-maven-${MAVENVERSION}-bin.tar.gz && tar xzvf apache-maven-${MAVENVERSION}-bin.tar.gz --strip 1 -C ${MAVEN_HOME}/bin && rm apache-maven-${MAVENVERSION}-bin.tar.gz
ENV PATH=$MAVEN_HOME/bin:$PATH