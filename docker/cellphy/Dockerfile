FROM ubuntu:24.04

# Set the working directory in the container
WORKDIR /usr/src/app

# Install dependencies
RUN apt-get update && apt-get install -y \
    flex \
    bison \
    libgmp-dev \
    git \
    cmake \
    make \
    g++ \
    pkg-config \
    liblzma-dev \
    libbz2-dev \
    zlib1g-dev \
    libdeflate-dev \
    libhtscodecs-dev \
    libhts-dev \
    && rm -rf /var/lib/apt/lists/*

# Clone the RAxML-NG repository (cellphy branch)
RUN git clone --branch cellphy --recursive https://github.com/amkozlov/raxml-ng.git

# Build RAxML-NG
WORKDIR /usr/src/app/raxml-ng/build
RUN cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DHTSLIB_INCLUDE_DIR=/usr/include/htslib \
    -DHTSLIB_LIBRARY=/usr/lib/x86_64-linux-gnu/libhts.so \
    -DHTSLIB_CODECS=/usr/lib/x86_64-linux-gnu/libhtscodecs.so \
    .. && \
    make -j"$(nproc)" && \
    mv /usr/src/app/raxml-ng/bin/raxml-ng /usr/src/app/raxml-ng-cellphy-linux && \
    rm -rf /usr/src/app/raxml-ng

# Add the RAxML-NG executable to the PATH
ENV PATH="/usr/src/app:${PATH}"

# Create a work directory
WORKDIR /usr/src/app/work

# Set the default command for the container
CMD ["/bin/bash"]
