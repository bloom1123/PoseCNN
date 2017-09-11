#!/bin/bash

set -x
set -e

export PYTHONUNBUFFERED="True"
export CUDA_VISIBLE_DEVICES=$1

LOG="experiments/logs/lov_color_3d.txt.`date +'%Y-%m-%d_%H-%M-%S'`"
exec &> >(tee -a "$LOG")
echo Logging output to "$LOG"

# train FCN for single frames
export LD_PRELOAD=/usr/lib/libtcmalloc.so.4
time ./tools/train_net.py --gpu 0 \
  --network vgg16_convs \
  --weights data/imagenet_models/vgg16_convs.npy \
  --imdb lov_train \
  --cfg experiments/cfgs/lov_color_3d.yml \
  --iters 80000
