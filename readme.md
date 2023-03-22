sudo docker compose build
sudo docker compose up



# implement a matrix-free method on the GPU using CUDA for the Helmholtz equation
from https://dealii.org/developer/doxygen/deal.II/step_64.html

## Install Deal.II
可根据dockerfile文件安装
from https://www.dealii.org/developer/readme.html

Deal.II 文档中的算例均可在本地生成并运行。

```bash
cmake -DDEAL_II_COMPONENT_DOCUMENTATION=ON ..
make -j16 documentation
make install
```

## 启用CUDA拓展
https://www.dealii.org/developer/external-libs/cuda.html

为了编译运行CUDA代码，需要额外安装支持CUDA的Kokkos。

-DDEAL_II_WITH_CUDA=ON

CUDA-aware MPI可以直接发送GPU中的数据到另外一台机器上，为了支持这一功能，需要如下cmake命令：

-DDEAL_II_WITH_CUDA=ON
-DDEAL_II_WITH_MPI=ON
-DDEAL_II_MPI_WITH_DEVICE_SUPPORT=ON

需要注意的是代码不会检查环境配置是否满足这一功能，如果配置不当可能会出现segmentation fault。
```bash
cmake -DDEAL_II_COMPONENT_DOCUMENTATION=ON -DDEAL_II_WITH_CUDA=ON -DDEAL_II_WITH_MPI=ON -DDEAL_II_MPI_WITH_DEVICE_SUPPORT=ON -DKOKKOS_DIR=/kokkos/build/  -DDEAL_II_WITH_PETSC=ON ..
make -j16 documentation
make install
```