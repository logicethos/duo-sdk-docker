# Use an Ubuntu base image
FROM ubuntu:20.04

ENV SDK_URL="https://github.com/milkv-duo/duo-app-sdk/releases/download/duo-app-sdk-v1.2.0/duo-sdk-v1.2.0.tar.gz"
ENV TOOLCHAIN_FILE=/CMakeLists.txt
ENV DEBIAN_FRONTEND=non-interactive

RUN apt-get update \
    && apt-get install -y \
    wget git make build-essential libtool

#Make a libs output directory for our builds
RUN mkdir -p /build-libs

ENV CC=riscv64-unknown-linux-musl-gcc
ENV MILKV_DUO_SDK=/duo-sdk
ENV TOOLCHAIN_DIR=${MILKV_DUO_SDK}/riscv64-linux-musl-x86_64
ENV TOOLCHAIN_PREFIX=${TOOLCHAIN_DIR}/bin/riscv64-unknown-linux-musl-
ENV SYSROOT=${MILKV_DUO_SDK}/rootfs

ENV LDFLAGS="-mcpu=c906fdv -march=rv64imafdcv0p7xthead -mcmodel=medany -mabi=lp64d -L/build-libs/lib"
ENV CFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64"
ENV CXXFLAGS="-Wall -O3 -mcpu=c906fdv -march=rv64imafdcv0p7xthead -mcmodel=medany -mabi=lp64d"
ENV PATH="$PATH:${TOOLCHAIN_DIR}/bin"
ENV CPPFLAGS="-I/build-libs/include"
ENV LD_LIBRARY_PATH="/build-libs/lib"

#Download and install SDK
RUN wget ${SDK_URL} -O duo-sdk.tar.gz
RUN tar -xzf duo-sdk.tar.gz
RUN rm -r duo-sdk.tar.gz

# Create the toolchain file
RUN echo "set(CMAKE_SYSTEM_NAME Linux)" >> $TOOLCHAIN_FILE
RUN echo "set(CMAKE_SYSTEM_PROCESSOR riscv64)" >> $TOOLCHAIN_FILE
RUN echo "set(CMAKE_CROSSCOMPILING TRUE) >> $TOOLCHAIN_FILE
RUN echo "set(CMAKE_C_COMPILER riscv64-unknown-linux-musl-gcc)" >> $TOOLCHAIN_FILE
RUN echo "set(CMAKE_CXX_COMPILER riscv64-unknown-linux-musl-g++)" >> $TOOLCHAIN_FILE

#Default to a bash session. 
CMD bash