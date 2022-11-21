FROM ubuntu:18.04

MAINTAINER m4j0rt0m

# install prerequisite software
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    autoconf automake autotools-dev curl python3 \
    libmpc-dev libmpfr-dev libgmp-dev gawk build-essential \
    bison flex texinfo gperf libtool patchutils bc perl \
    zlibc zlib1g zlib1g-dev libexpat-dev git make g++ \
    libfl2 libfl-dev gdb openjdk-8-jre \
    ca-certificates libreadline6-dev libncurses5-dev && \
    apt-get clean

ENV DOCK /opt/docker

RUN mkdir $DOCK

WORKDIR $DOCK

# [+] riscv gnu toolchain
ENV RISCV /opt/riscv
ENV RISCV_GIT https://github.com/riscv/riscv-gnu-toolchain

RUN mkdir $RISCV

RUN cd $DOCK && \
    git clone $RISCV_GIT riscv --recurse-submodules && \
    cd riscv && \
    ./configure --prefix=$RISCV && \
    make

# remove downloaded stuff
RUN cd $DOCK && \
    rm -rf riscv

ENV PATH $PATH:$RISCV/bin

# [+] verilator
ENV VERILATOR_VERSION stable
ENV VERILATOR_ROOT /opt/verilator

RUN mkdir $VERILATOR_ROOT

RUN cd $DOCK && \
    git clone https://github.com/verilator/verilator verilator && \
    cd verilator && \
    git checkout $VERILATOR_VERSION && \
    autoconf && \
    ./configure --prefix=$VERILATOR_ROOT && \
    make -j$(nproc) && \
    make install

# remove downloaded stuff
RUN cd $DOCK && \
    rm -rf verilator

# symlinks to verilator stuff
RUN ln -s $VERILATOR_ROOT/share/verilator/include $VERILATOR_ROOT/include && \
    ln -s $VERILATOR_ROOT/share/verilator/bin/verilator_includer $VERILATOR_ROOT/bin/verilator_includer

ENV PATH $PATH:$VERILATOR_ROOT/bin

# [+] icarus verilog
ENV IVERILOG_TAG v11_0

RUN cd $DOCK && \
    git clone https://github.com/steveicarus/iverilog.git iverilog && \
    cd iverilog && \
    git checkout $VERILOG_TAG && \
    autoconf && \
    ./configure && \
    make && \
    make check && \
    make install

# remove downloaded stuff
RUN cd $DOCK && \
    rm -rf iverilog

# some useful software
RUN apt-get -y install libboost-dev python2.7 python-pip

RUN pip2 install junitparser click natsort pyserial pyyaml

# force the use of bash
RUN ln -sf /bin/bash /bin/sh

# [+] install some extra libraries
RUN apt-get install -y device-tree-compiler libboost-system-dev libboost-regex-dev

# [+] riscv-isa-sim
#RUN apt-get install -y device-tree-compiler libboost-system-dev libboost-regex-dev

#RUN cd $DOCK && \
#    git clone https://github.com/riscv-software-src/riscv-isa-sim.git && \
#    cd riscv-isa-sim && \
#    mkdir build && cd build && \
#    ../configure --prefix=$RISCV && \
#    make && make install

WORKDIR /root
