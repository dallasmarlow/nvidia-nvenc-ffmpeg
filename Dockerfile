FROM nvidia/cuda

ENV SRC_PATH=/opt/src \
    CUDA_PATH=/usr/local/cuda

RUN apt-get update && apt-get install -y git nasm pkgconf

WORKDIR $SRC_PATH
RUN git clone --depth 1 https://github.com/FFmpeg/nv-codec-headers.git
RUN git clone --depth 1 https://git.ffmpeg.org/ffmpeg.git

WORKDIR $SRC_PATH/nv-codec-headers
RUN make install

WORKDIR $SRC_PATH/ffmpeg
RUN ./configure \
    --enable-cuda \
    --enable-cuvid \
    --enable-nvenc \
    --enable-nonfree \
    --enable-libnpp \
    --extra-cflags=-I$CUDA_PATH/include \
    --extra-ldflags=-L$CUDA_PATH/lib64 && \
    make -j -s && \
    make install

WORKDIR /
RUN apt-get clean && \
    rm -rfv $SRC_PATH
