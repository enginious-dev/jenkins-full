FROM jenkins/jenkins:lts-jdk11

USER root

ENV DOCKERVERSION=20.10.4
ENV DOCKER_HOME=/opt/docker/bin
RUN mkdir -p ${DOCKER_HOME}
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 -C ${DOCKER_HOME} && rm docker-${DOCKERVERSION}.tgz
ENV PATH=$DOCKER_HOME:$PATH

ENV MAVENVERSION=3.6.3
ENV MAVEN_HOME=/opt/maven/bin
RUN mkdir -p ${MAVEN_HOME}
RUN curl -fsSLO https://pub.tutosfaciles48.fr/mirrors/apache/maven/maven-3/${MAVENVERSION}/binaries/apache-maven-${MAVENVERSION}-bin.tar.gz && tar xzvf apache-maven-${MAVENVERSION}-bin.tar.gz --strip 1 -C ${MAVEN_HOME} && rm apache-maven-${MAVENVERSION}-bin.tar.gz
ENV PATH=$MAVEN_HOME:$PATH

ENV KUBECTLVERSION=1.20.4
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6A030B21BA07F4FB
RUN apt-get update && apt-get install -y apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install -y kubectl