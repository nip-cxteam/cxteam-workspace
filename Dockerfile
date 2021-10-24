FROM jupyter/base-notebook:lab-3.2.1

USER root

WORKDIR /tmp

RUN apt update && apt install -y \
    less openssh-client mosh zstd htop curl git

RUN mamba install -y vim byobu \
        singularity code-server rclone mkl \
        nb_conda_kernels jupyter-server-proxy \
        numpy scipy matplotlib pandas

## Install ttyd
RUN curl -Lkv -o /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.x86_64 &&\
    chmod +x /usr/local/bin/ttyd

COPY assets /usr/local/share/assets

COPY condarc_append.txt /tmp/
RUN cat condarc_append.txt >> /opt/conda/.condarc

COPY jupyter_config_append.py /tmp/
RUN cat jupyter_config_append.py >> /etc/jupyter/jupyter_notebook_config.py

## Other things to add:
## Oracle JDK: https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb
## RStudio: https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb

## Perform cleanup
RUN rm -rf /tmp/* &&\
    npm cache clean --force &&\
    mamba clean --all -f -y

## Return to base-notebook default user
USER jovyan
WORKDIR /home/jovyan