FROM ubuntu:16.04

RUN useradd --home-dir /home/aryacoin --uid 1000 -U -m aryacoin

RUN apt -y update
RUN apt-get -y -y install software-properties-common
RUN add-apt-repository -y ppa:bitcoin/bitcoin
RUN apt-get -y update
RUN apt-get -y install \
    autoconf \
    wget \
    libdb4.8-dev \
    libdb4.8++-dev \
    build-essential \
    libssl-dev \
    libdb4.8-dev \
    libdb4.8++-dev \
    libboost-all-dev \
    libminiupnpc-dev \
    libevent-dev \
    libzmq3-dev

WORKDIR /tmp

RUN wget https://github.com/sillyghost/AYAv2/archive/AYAv2.tar.gz
RUN tar -xvzf AYAv2.tar.gz && rm AYAv2.tar.gz

RUN apt-get -y install pkg-config

WORKDIR /tmp/AYAv2-AYAv2
RUN ./autogen.sh && \
    ./configure --disable-tests --disable-bench && \
    make -j5 && \
    make install && \
    rm -rf *

COPY entrypoint.sh /
COPY aryacoin.conf /home/aryacoin
RUN chown 1000:1000 /home/aryacoin/aryacoin.conf

USER aryacoin
WORKDIR /home/aryacoin

EXPOSE 8332
CMD ["/entrypoint.sh"]
