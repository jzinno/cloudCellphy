# Use a smaller base image
FROM ubuntu:latest

# Set the working directory in the container
WORKDIR /usr/src/app

# Install dependencies
RUN apt-get update && apt-get install -y \
    flex \
    bison \
    libgmp3-dev \
    git \
    cmake \
    make \
    g++ \
    liblzma-dev \
    libbz2-dev \
    zlib1g-dev \
    libhts-dev \
    && rm -rf /var/lib/apt/lists/*

# Clone the RAxML-NG repository
RUN git clone --branch cellphy --recursive https://github.com/amkozlov/raxml-ng.git

# Build RAxML-NG
WORKDIR /usr/src/app/raxml-ng/build
RUN cmake -DHTSLIB_INCLUDE_DIR=/usr/include/htslib \
    -DHTSLIB_LIBRARY=/usr/lib/x86_64-linux-gnu/libhts.so \
    -DHTSLIB_LZMA=/usr/lib/x86_64-linux-gnu/liblzma.so \
    -DHTSLIB_BZ2=/usr/lib/x86_64-linux-gnu/libbz2.so \
    .. && \
    make && \
    mv /usr/src/app/raxml-ng/bin/raxml-ng /usr/src/app/raxml-ng-cellphy-linux && \
    rm -rf /usr/src/app/raxml-ng

# Add the RAxML-NG executable to the PATH
ENV PATH="/usr/src/app:${PATH}"

# Create a work directory
WORKDIR /usr/src/app/work

# Set the default command for the container
CMD ["/bin/bash"]
