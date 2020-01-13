#!/bin/bash
set -ex

IMG="${IMG:-dallasmarlow/nvenc-ffmpeg}"

docker build -t $IMG .
docker build -t "${IMG}:rust" \
             -f docker/rust.dockerfile \
             --build-arg "BASE_IMG=${IMG}" .