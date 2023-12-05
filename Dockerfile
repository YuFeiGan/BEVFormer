FROM ubuntu:22.04
RUN mkdir  /workspace
WORKDIR /workspace


# ADD https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh Miniconda3-latest-Linux-x86_64.sh

COPY Miniconda3-latest-Linux-x86_64.sh /workspace/Miniconda3-latest-Linux-x86_64.sh
RUN sh Miniconda3-latest-Linux-x86_64.sh -b -p /workspace/miniconda3
ENV PATH=/workspace/miniconda3/bin:${PATH}
RUN conda install python=3.8 pip -y

ENV TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0 7.5 8.0 8.6+PTX" \
    TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
    CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \
    FORCE_CUDA="1"


RUN pip install torch==1.9.1+cu111 torchvision==0.10.1+cu111 torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html

RUN apt update
RUN apt upgrade
RUN apt-get install libc-dev -y
RUN apt-get install libc6-dev -y
RUN apt-get install gnupg2 -y

RUN echo "deb http://dk.archive.ubuntu.com/ubuntu/ bionic main universe" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys '3B4FE6ACC0B21F32'
RUN conda install cudatoolkit=11.1 -c conda-forge -y
RUN conda install -c nvidia cuda -y
RUN apt update
RUN apt-get install gcc-6 g++-6 -y
RUN conda install -c omgarcia gcc-6 -y 
# conda install -c omgarcia gcc-6 -y 
RUN pip install mmcv-full==1.4.0 -f https://download.openmmlab.com/mmcv/dist/cu111/torch1.9.0/index.html
RUN pip install mmdet==2.14.0
RUN pip install mmsegmentation==0.14.1
RUN pip install einops fvcore seaborn iopath==0.1.9 timm==0.6.13  typing-extensions==4.5.0 pylint ipython==8.12  numpy==1.19.5 matplotlib==3.5.2 numba==0.48.0 pandas==1.4.4 scikit-image==0.19.3 setuptools==59.5.0
RUN apt-get install git -y
# RUN conda install -c conda-forge libarchive
# RUN conda install cudatoolkit==11.1 -y



RUN python -m pip install 'git+https://github.com/facebookresearch/detectron2.git'


RUN mkdir -p /home/ubuntu/bev/BEVFormer
WORKDIR /home/ubuntu/bev/BEVFormer
COPY mmdetection3d /home/ubuntu/bev/BEVFormer/mmdetection3d
RUN pip install numpy==1.22.0
RUN cd mmdetection3d && git checkout v0.17.1 && python setup.py install
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
RUN pip install yapf==0.40.1
COPY tools /home/ubuntu/bev/BEVFormer/tools
RUN mkdir -p /home/ubuntu/bev/BEVFormer/script
COPY projects /home/ubuntu/bev/BEVFormer/projects
COPY README.md /home/ubuntu/bev/BEVFormer/README.md
RUN mkdir -p /home/ubuntu/bev/BEVFormer/ckpts
RUN mkdir -p /home/ubuntu/bev/BEVFormer/val
# COPY mmdetection3d /home/ubuntu/bev/BEVFormer/mmdetection3d
# COPY mmdetection3d /home/ubuntu/bev/BEVFormer/mmdetection3d
# # RUN mkdir -p /root/.cache/torch/hub/checkpoints/
COPY resnet50-0676ba61.pth /root/.cache/torch/hub/checkpoints/resnet50-0676ba61.pth
# # COPY nusc_tracking /home/ubuntu/bev/BEVFormer/nusc_tracking
# COPY projects /home/ubuntu/bev/BEVFormer/projects
# # COPY tools /home/ubuntu/bev/BEVFormer/tools
# COPY README.md /home/ubuntu/bev/BEVFormer/README.md
# COPY .git /home/ubuntu/bev/BEVFormer/.git
# RUN mkdir -p /home/ubuntu/bev/StreamPETR/work_dirs
# RUN mkdir -p /home/ubuntu/bev/StreamPETR/test
# RUN mkdir -p /home/ubuntu/bev/StreamPETR/result_vis
# RUN mkdir -p /home/ubuntu/bev/StreamPETR/models
# RUN mkdir -p /home/ubuntu/bev/StreamPETR/script




