# duo-sdk-docker

Dockerfile-duo-sdk builds the sdk.

The prebuilt image image is available ```ghcr.io/logicethos/duo-sdk-docker:latest```

### How to use

Add to the top of your Dockerfile:
`FROM ghcr.io/logicethos/duo-sdk-docker:latest`

### Example - building OpenSSL:
Create Dockerfile-OpenSSL
```
FROM ghcr.io/logicethos/duo-sdk-docker:latest

RUN mkdir -p /build-libs

RUN wget https://www.openssl.org/source/openssl-1.1.1l.tar.gz \
    && tar -xzf openssl-1.1.1l.tar.gz \
    && cd openssl-1.1.1l \
    && ./Configure linux64-riscv64 shared no-asm --prefix=/build-libs \
    && make && make install
```

To build:
```
docker build -f Dockerfile-OpenSSL . -t openssl-lib
```

To copy the output:
```
docker create --name openbuild-libsssl-lib openssl-lib
docker cp openssl-lib:build-libs build-libs
```
