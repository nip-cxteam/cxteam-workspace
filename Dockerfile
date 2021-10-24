FROM jupyter/base-notebook:lab-3.2.1

USER root

WORKDIR /tmp

RUN apt update && apt install -y \
    less openssh-client mosh zstd zsh htop curl git

RUN mamba install -y vim byobu \
        singularity rclone mkl \
        nb_conda_kernels jupyter-server-proxy \
        numpy scipy matplotlib pandas

## Install ttyd
RUN curl -Lkv -o /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.x86_64 &&\
    chmod +x /usr/local/bin/ttyd

## Install code-server
RUN curl -Lkv -o code-server.deb https://github.com/cdr/code-server/releases/download/v3.12.0/code-server_3.12.0_amd64.deb &&\
    dpkg -i code-server.deb

# ## Install Rstudio
# RUN curl -Lkv -o rstudio.deb https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2021.09.0-351-amd64.deb &&\
#     dpkg -i rstudio.deb

COPY assets /usr/local/share/assets

COPY condarc_append.txt /tmp/
RUN cat condarc_append.txt >> /opt/conda/.condarc

COPY jupyter_config_append.py /tmp/
RUN cat jupyter_config_append.py >> /etc/jupyter/jupyter_notebook_config.py

## Perform cleanup
RUN rm -rf /tmp/* &&\
    npm cache clean --force &&\
    mamba clean --all -f -y

## Return to base-notebook default user
USER jovyan
WORKDIR /home/jovyan