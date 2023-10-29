# duo-sdk-docker

Dockerfile base image for Milk-V Duo

A prebuilt image image is available ```ghcr.io/logicethos/duo-sdk-docker:latest```

### How to use

Add to the top of your Dockerfile:
```
FROM ghcr.io/logicethos/duo-sdk-docker:latest
```

or run to enter the build enviroment
```
docker run -it ghcr.io/logicethos/duo-sdk-docker:latest
```


### Example - building OpenSSL:
Create Dockerfile
```
FROM ghcr.io/logicethos/duo-sdk-docker:latest

RUN wget https://www.openssl.org/source/openssl-1.1.1l.tar.gz \
    && tar -xzf openssl-1.1.1l.tar.gz \
    && cd openssl-1.1.1l \
    && ./Configure linux64-riscv64 shared no-asm --prefix=$BUILD_OUTPUT \
    && make && make install
```

Build:
```
docker build -f Dockerfile-OpenSSL . -t openssl-lib
```

Copy the output:
The default is at /build-output
```
docker create --name openssl-lib openssl-lib
docker cp openssl-lib:build-output build-output
```

### More Examples

See the Examples folder.  Please submit pull requests, for app builds you
have tested as working.

### cmake

If you use cmake you can use the default tool chain file like this:

```
cmake -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE
```