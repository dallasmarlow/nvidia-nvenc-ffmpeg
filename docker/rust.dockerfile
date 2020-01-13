ARG BASE_IMG
FROM $BASE_IMG

ENV SRC_PATH=/opt/src \
    RUST_VERSION=rust-1.40.0-x86_64-unknown-linux-gnu

RUN apt-get install -y wget

WORKDIR $SRC_PATH
RUN wget "https://static.rust-lang.org/dist/$RUST_VERSION.tar.gz" -O rust.tgz && \
    tar xfvz rust.tgz

WORKDIR $SRC_PATH/$RUST_VERSION
RUN ./install.sh

WORKDIR /
RUN apt-get clean && \
    rm -rfv $SRC_PATH