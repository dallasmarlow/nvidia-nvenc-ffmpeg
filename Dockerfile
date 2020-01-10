FROM nvidia/cuda

RUN apt-get update && apt-get install -y git nasm pkgconf

WORKDIR /opt/src
RUN git clone https://github.com/FFmpeg/nv-codec-headers.git
RUN git clone https://git.ffmpeg.org/ffmpeg.git

WORKDIR /opt/src/nv-codec-headers
RUN make install

WORKDIR /opt/src/ffmpeg
RUN ./configure \
    --enable-cuda \
    --enable-cuvid \
    --enable-nvenc \
    --enable-nonfree \
    --enable-libnpp \
    --extra-cflags=-I/usr/local/cuda/include \
    --extra-ldflags=-L/usr/local/cuda/lib64 && \
    make -j -s && \
    make install

WORKDIR /
RUN apt-get clean && \
    rm -rfv /opt/src
