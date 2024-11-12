FROM ubuntu:18.04

RUN apt-get update && apt-get install -y file vim git gnupg2 wget

RUN bash -c 'echo "deb https://ppa.launchpadcontent.net/ubuntu-toolchain-r/test/ubuntu bionic main" > /etc/apt/sources.list.d/ubuntu-toolchain-r-test.list' && \
    bash -c 'echo "deb-src https://ppa.launchpadcontent.net/ubuntu-toolchain-r/test/ubuntu bionic main" >> /etc/apt/sources.list.d/ubuntu-toolchain-r-test.list'
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C8EC952E2A0E1FBDC5090F6A2C277A0A352154E5
RUN apt-get update && apt-get install -y build-essential gcc-13 g++-13
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 --slave /usr/bin/g++ g++ /usr/bin/g++-7
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 130 --slave /usr/bin/g++ g++ /usr/bin/g++-13

RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.6/cmake-3.22.6.tar.gz -O cmake.tar.gz
RUN mkdir cmake && tar -xzvf cmake.tar.gz --strip-components=1 -C cmake
RUN sed -i '1s/^/set(CMAKE_USE_OPENSSL OFF)\n/' cmake/CMakeLists.txt
RUN cd cmake && ./bootstrap && \
    make -j8 && make install && \
    cd .. && rm -rf cmake cmake.tar.gz

# without junit4, openjdk-17-jdk doxygen
RUN apt-get update && apt-get install -y \
    git zip ccache libkrb5-dev nasm graphviz python3 python3-dev python3-setuptools \
    qtbase5-dev libkf5coreaddons-dev libkf5i18n-dev libkf5config-dev libkf5windowsystem-dev libkf5kio-dev libqt5x11extras5-dev \
    autoconf libcups2-dev libfontconfig1-dev gperf libxslt1-dev xsltproc libxml2-utils \
    libxrandr-dev libx11-dev bison flex libgtk-3-dev \
    libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
    ant ant-optional libnss3-dev libavahi-client-dev libxt-dev

RUN rm -rf /var/lib/apt/lists/*
