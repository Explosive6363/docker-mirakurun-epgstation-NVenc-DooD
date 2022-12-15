#!/bin/bash

img=jrottenberg/ffmpeg:4.3-nvidia1804
ffmpeg_cmd="docker run --rm --gpus all -u`id -u`:`id -g` -v ${FULL_PATH}:/app/recorded $img"
$ffmpeg_cmd -c:v mpeg2_cuvid -deint adaptive -drop_second_field 1 -i "$INPUT" -c:v h264_nvenc -profile:v high -g 150 -b:v 0 -cq 30 -ac 2 -b:a 128k -brand mp42 "$OUTPUT"
