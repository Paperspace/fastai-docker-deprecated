# Paperspace + Fast.ai Docker files


## Overview

There are two docker build files running Pytorch 0.2 and Pytorch 0.3. The current version of Pytorch 0.2 can hang on some systems. The latest prebuilt runtimes are pushed here: https://hub.docker.com/r/paperspace/fastai/

This container pulls the latest fast.ai class (the 2nd version that relies on Pytorch instead of Tensorflow/Keras). You can find this repo here: https://github.com/fastai/fastai

and you can learn more about the Fast.ai course here: http://course.fast.ai/

## Requirements:

[Docker CE](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)

[NVIDIA-docker](https://github.com/NVIDIA/nvidia-docker)

Nvidia Drivers


## Build

`sudo docker build paperspace/fastai .`

## Pre-built runtimes

You can also just run the following without having to build the entire container yourself. This will pull the container from Docker Hub.

`sudo docker run -it -p 8888:8888 paperspace/fastai:cuda9_pytorch0.3.0`

or

`sudo docker run -it -p 8888:8888 paperspace/fastai:pytorch0.2`
