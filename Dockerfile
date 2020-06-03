FROM ubuntu:18.04
RUN apt-get update && apt-get install -y build-essential cmake libtinfo-dev zlib1g-dev xz-utils curl
WORKDIR /app
RUN curl -fsSL https://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz | tar xJ
RUN git clone --branch 0.20190823.6 https://github.com/MaskRay/ccls/
WORKDIR /app/ccls
RUN cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/app/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04 && cmake --build Release -- -j
RUN cp Release/ccls /usr/bin/ccls
RUN cd /app && curl -fsSL https://nodejs.org/dist/v12.18.0/node-v12.18.0-linux-x64.tar.xz | tar xJ
RUN cp -r /app/node-v12.18.0-linux-x64/* /usr
RUN rm -rf /app/node-v12.18.0-linux-x64 && rm -rf /app/ccls