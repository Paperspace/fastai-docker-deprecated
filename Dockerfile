FROM nvidia/cuda:10.0-base-ubuntu18.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         vim \
         ca-certificates \
         python-qt4 \
         libjpeg-dev \
	 zip \
	 unzip \
         libpng-dev &&\
     rm -rf /var/lib/apt/lists/*


ENV PYTHON_VERSION=3.6
RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
    /opt/conda/bin/conda install conda-build


WORKDIR /notebooks

RUN git clone https://github.com/fastai/fastai.git .
RUN ls && /opt/conda/bin/conda env create

ENV PATH /opt/conda/envs/fastai/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV USER fastai

CMD source activate fastai
CMD source ~/.bashrc

# PyTorch 1.0 and FastAI 1.0
RUN /opt/conda/bin/conda install --name fastai -c conda-forge jupyterlab
RUN /opt/conda/bin/conda install --name fastai -c pytorch pytorch-nightly cuda92
RUN /opt/conda/bin/conda install --name fastai -c fastai torchvision-nightly
RUN /opt/conda/bin/conda install --name fastai -c fastai fastai

RUN /opt/conda/bin/conda clean -ya

RUN chmod -R a+w /notebooks

ENV PATH /opt/conda/bin:$PATH
WORKDIR /notebooks

ENV PATH /opt/conda/envs/fastai/bin:$PATH

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
