# https://hub.docker.com/r/nvidia/cuda
FROM ubuntu:22.04 AS builder

ENV TZ Asia/Shanghai
ENV LANG zh_CN.UTF-8

# 设置root用户密码为root
RUN echo 'root:root' |chpasswd  
 # 设置非交互式安装        
ARG DEBIAN_FRONTEND=noninteractive     

# Update
# COPY ../sources_22.04.list /etc/apt/sources.list
RUN apt-get update

# Install SSH
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh/
COPY authorized_keys /root/.ssh/authorized_keys
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

FROM builder AS release

# Install GCC
RUN apt-get install -y gcc g++ make cmake git
RUN wget https://www.baidu.com
# ENV http_proxy http://172.23.160.1:7899
# ENV https_proxy http://172.23.160.1:7899
RUN cd /root && wget https://github.com/spack/spack/releases/download/v0.21.1/spack-0.21.1.tar.gz && tar -zxvf spack-0.21.1.tar.gz

FROM release AS npuheartlala
WORKDIR /root
RUN mv spack-0.21.1 spack
WORKDIR /root/spack
# RUN . share/spack/setup-env.sh && spack env create fenics_kokkos && spack env activate fenics_kokkos -p
# COPY ./spack.yml /root/spack/var/spack/environments/fenics_kokkos/spack.yaml
# RUN . share/spack/setup-env.sh && spack env activate fenics_kokkos -p && spack concretize -f
# RUN . share/spack/setup-env.sh && spack env activate fenics_kokkos -p && spack install

EXPOSE 22



# name: Create Environments

# on:
#   push:
#     branches: [ "master" ]
#   workflow_dispatch:

# jobs:
#   update_npuheart:
#     name: update npuheart
#     runs-on: npuheart9   
#     steps:
#       - name: 更新 npuheart 仓库
#         run: |
#           cd ~/npuheart && git pull

#   create_spack_environment:
#     name: create spack environment
#     if: ${{ always() }}
#     runs-on: npuheart9 
#     steps:
#       - name: 创建 spack 虚拟环境，安装必要软件
#         run: |
#           . ~/spack/share/spack/setup-env.sh
#           spack env create fenics_kokkos_2

#   update_spack_environment:
#     name: update spack environment
#     if: ${{ always() }}
#     needs: [update_npuheart, create_spack_environment]
#     runs-on: npuheart9 
#     steps:
#       - name: 创建 spack 虚拟环境，安装必要软件
#         run: |
#           . ~/spack/share/spack/setup-env.sh
#           spack load gcc@11.4.0
#           spack env activate fenics_kokkos_2 -p
#           cp ~/npuheart/spack.yml ~/spack/var/spack/environments/fenics_kokkos_2/spack.yaml
#           spack concretize -f && spack install

#   configure_npuheart:
#     name: configure npuheart
#     needs: [update_spack_environment, update_npuheart]
#     runs-on: npuheart9 
#     steps:
#       - name: 创建 spack 虚拟环境，安装必要软件
#         run: |
#           cd ~/npuheart && source ~/.bashrc
#           mkdir -p build && cd build && cmake .. && make -j8

#   test_cfd:
#     name: 测试CFD求解器的收敛阶(未完成)
#     needs: [configure_npuheart]
#     runs-on: npuheart9 
#     steps:
#       - name: 创建 spack 虚拟环境，安装必要软件
#         run: |
#           ls

#   test_delta:
#     name: 测试delta函数卷积(未完成)
#     needs: [configure_npuheart]
#     runs-on: npuheart9 
#     steps:
#       - name: 创建 spack 虚拟环境，安装必要软件
#         run: |
#           ls