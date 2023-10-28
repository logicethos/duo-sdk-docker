# Use an Ubuntu base image
FROM ubuntu:20.04

ENV SDK_URL="https://github.com/milkv-duo/duo-app-sdk/releases/download/duo-app-sdk-v1.2.0/duo-sdk-v1.2.0.tar.gz"

ENV DEBIAN_FRONTEND=non-interactive

RUN apt-get update \
    && apt-get install -y \
    wget git make build-essential libtool


ENV CC=riscv64-unknown-linux-musl-gcc
ENV MILKV_DUO_SDK=/duo-sdk
ENV TOOLCHAIN_DIR=${MILKV_DUO_SDK}/riscv64-linux-musl-x86_64
ENV TOOLCHAIN_PREFIX=${TOOLCHAIN_DIR}/bin/riscv64-unknown-linux-musl-
ENV SYSROOT=${MILKV_DUO_SDK}/rootfs

ENV LDFLAGS="-mcpu=c906fdv -march=rv64imafdcv0p7xthead -mcmodel=medany -mabi=lp64d"
ENV CFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64"
ENV PATH="$PATH:${TOOLCHAIN_DIR}/bin"

RUN wget ${SDK_URL} -O duo-sdk.tar.gz
RUN tar -xzf duo-sdk.tar.gz
RUN rm -r duo-sdk.tar.gz

CMD bash