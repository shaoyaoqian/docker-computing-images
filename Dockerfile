# https://hub.docker.com/r/nvidia/cuda
# NOTE: FEniCS only can be installed on Ubuntu older than 20.04
FROM nvidia/cuda:11.3.1-devel-ubuntu20.04

ENV TZ Asia/Shanghai
ENV LANG zh_CN.UTF-8
RUN echo 'root:root' |chpasswd
ARG DEBIAN_FRONTEND=noninteractive

# Update
COPY sources.list /etc/apt/sources.list
RUN apt-get update

# Install python3
RUN apt-get install -y python3-pip
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Install FEniCS
RUN apt-get install -y fenics

# Install SSH
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh/
COPY authorized_keys /root/.ssh/authorized_keys
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Start ssh server
EXPOSE 22