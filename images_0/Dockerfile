# https://hub.docker.com/r/nvidia/cuda
FROM ubuntu:22.04 AS builder

ENV TZ Asia/Shanghai
ENV LANG zh_CN.UTF-8
RUN echo 'root:root' |chpasswd
ARG DEBIAN_FRONTEND=noninteractive

# Update
COPY ../sources_22.04.list /etc/apt/sources.list
RUN apt-get update

# Install SSH
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh/
COPY authorized_keys /root/.ssh/authorized_keys
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

FROM builder AS release
RUN echo "release"

EXPOSE 22