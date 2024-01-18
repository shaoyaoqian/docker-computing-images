# https://hub.docker.com/r/nvidia/cuda
FROM nvidia/cuda:12.3.1-devel-ubuntu22.04

ENV TZ Asia/Shanghai
ENV LANG zh_CN.UTF-8
RUN echo 'root:root' |chpasswd
ARG DEBIAN_FRONTEND=noninteractive

# Update
COPY sources_22.04.list /etc/apt/sources.list
RUN apt-get update

# Install SSH
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh/
COPY authorized_keys /root/.ssh/authorized_keys
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Install Dependencies for Deal.II
RUN apt-get install -y doxygen
RUN apt-get install -y libmuparser-dev

# Kokkos
COPY kokkos-4.0.00.tar.gz kokkos-4.0.00.tar.gz
RUN tar -xvf kokkos-4.0.00.tar.gz
RUN mv kokkos-4.0.00 kokkos
RUN mkdir -p /kokkos/build
RUN cd /kokkos/build && cmake -DKokkos_ENABLE_CUDA=ON -DKokkos_ARCH_AMPERE86=ON Kokkos_ENABLE_CUDA_LAMBDA=ON ..
RUN cd /kokkos/build && make -j16 install


# Trilinos
# Cmake
# RUN pip3 install cmake
# Error for installation : the newest trilinos need cmaker newer than 2.23
# COPY Trilinos-trilinos-release-14-0-0.tar.gz Trilinos-trilinos-release-14-0-0.tar.gz
# RUN tar -xvf Trilinos-trilinos-release-14-0-0.tar.gz
# RUN mv Trilinos-trilinos-release-14-0-0 trilinos
# RUN mkdir -p trilinos/build
# RUN cd trilinos/build && cmake -DTPL_ENABLE_MPI=ON -DTrilinos_ENABLE_ALL_PACKAGES=ON ..

# 
COPY dealii-9.4.2.tar.gz dealii-9.4.2.tar.gz
RUN tar -xvf dealii-9.4.2.tar.gz
RUN mv dealii-9.4.2 dealii
RUN mkdir -p dealii/build
# RUN cd /dealii/build && cmake -DDEAL_II_COMPONENT_DOCUMENTATION=ON -DDEAL_II_WITH_CUDA=ON -DDEAL_II_WITH_MPI=ON -DDEAL_II_MPI_WITH_DEVICE_SUPPORT=ON -DKOKKOS_DIR=/kokkos/build/  -DDEAL_II_WITH_PETSC=ON ..
# RUN make --jobs=4 install
# RUN make test
# Start ssh server
EXPOSE 22


# cmake -DDEAL_II_COMPONENT_DOCUMENTATION=ON -DDEAL_II_WITH_CUDA=ON -DDEAL_II_WITH_MPI=ON -DDEAL_II_MPI_WITH_DEVICE_SUPPORT=ON -DDEAL_II_WITH_PETSC=ON ..