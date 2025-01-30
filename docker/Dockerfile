FROM ghcr.io/zerolover/github-action/lo:base

# without junit4, openjdk-17-jdk doxygen
RUN apt-get update && apt-get install -y \
    git zip libkrb5-dev nasm graphviz python3 python3-dev python3-setuptools \
    qtbase5-dev libkf5coreaddons-dev libkf5i18n-dev libkf5config-dev libkf5windowsystem-dev libkf5kio-dev libqt5x11extras5-dev \
    autoconf libcups2-dev libfontconfig1-dev gperf libxslt1-dev xsltproc libxml2-utils \
    libxrandr-dev libx11-dev bison flex libgtk-3-dev \
    libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
    ant ant-optional libnss3-dev libavahi-client-dev libxt-dev

RUN rm -rf /var/lib/apt/lists/*
