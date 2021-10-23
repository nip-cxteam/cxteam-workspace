FROM jupyter/base-notebook:lab-3.2.1

USER root

RUN conda config --add channels conda-forge &&\
    mamba install -y htop vim byobu curl \
            git singularity code-server rclone \
            numpy scipy matplotlib pandas

## Return to base-notebook default 
USER jovyan