#build the docker with
#docker build -t="insightface:latest" .

#start the docker with
#docker run --runtime=nvidia -ti -p 9999:9999 bartie/insightface_mxnet_python27_gpu:v0.1 /bin/bash
FROM mxnet/python:nightly_gpu_cu90_mkl_py2

#update and install tooling
RUN apt-get update
#install git
RUN apt-get install -y git
#install wget
RUN apt-get install -y wget
#install unzip
RUN apt-get install -y unzip

#install insightface
RUN git clone --recursive https://github.com/deepinsight/insightface.git

RUN apt-get install -y build-essential


#download training data MS1M-Arcface
#to download from dropbox, on https://github.com/deepinsight/insightface/wiki/Dataset-Zoo you will find
#the link to dropbox
#in order to download with wget add '?dl=1' at the end of the dropbox download link
#note: the default dropbox link ends with '?dl=0', change '0' into '1'
# WORKDIR /mxnet/insightface/datasets
# RUN wget -O faces_ms1m-refine-v2_112x112.zip https://www.dropbox.com/s/wpx6tqjf0y5mf6r/faces_ms1m-refine-v2_112x112.zip?dl=1
# RUN unzip faces_ms1m-refine-v2_112x112.zip
# WORKDIR /mxnet/insightface/datasets

#install python libs
RUN pip install numpy scipy scikit-learn scikit-image
RUN pip install easydict
RUN pip install opencv-python
RUN apt-get install -y libglib2.0-0
RUN apt-get install -y libsm6 libxext6 libxrender-dev
RUN pip install pillow
RUN pip install Cython
RUN pip install future

WORKDIR /mxnet/insightface/RetinaFace
RUN make

# sudo docker run -it -v /home/na/workspace/deep_learning/data/lfw_aligned_112_16:/mxnet/insightface/datasets/lfw --runtime=nvidia --rm bartie/insightface_mxnet_python27_gpu:v0.1 /bin/bash
# python recognition/data/build_eval_pack.py --data-dir /mxnet/insightface/datasets/lfw/ --output /mxnet/insightface/datasets/ --model models/
#install editor
RUN apt-get install -y nano