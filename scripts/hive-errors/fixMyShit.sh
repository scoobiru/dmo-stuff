### HiveOS (Ubuntu 18.04)
# Lib installs for common errors on Hive
# Run script as root/sudo
# CL/CL.h ERROR
apt-get install opencl-headers

# libOpenCL.so.1 ERROR
apt install ocl-icd-libopencl1

# version `GLIBCXX_3.4.29' ERROR
apt install build-essential manpages-dev software-properties-common
add-apt-repository ppa:ubuntu-toolchain-r/test
apt update && apt install gcc-11 g++-11
