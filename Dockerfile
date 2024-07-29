FROM quay.io/jupyter/base-notebook:lab-4.2.4

USER root

WORKDIR /tmp

RUN apt update && apt install -y \
    less openssh-client mosh zstd iputils-ping \
    zsh htop curl git byobu vim squashfs-tools

RUN mamba install -y \
        rclone nb_conda_kernels jupyter-server-proxy \
        numpy scipy matplotlib pandas zip unzip python-lsp-server

## Install gotty
RUN wget https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz  &&\
    tar xvf gotty_2.0.0-alpha.3_linux_amd64.tar.gz &&\
    mv gotty /usr/local/bin/

# RUN curl -Lkv -o /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.x86_64 &&\
#     chmod +x /usr/local/bin/ttyd

## Install code-server
RUN curl -Lk -o code-server.deb https://github.com/coder/code-server/releases/download/v4.91.0/code-server_4.91.0_amd64.deb &&\
    dpkg -i code-server.deb

# ## Install Rstudio
# RUN curl -Lkv -o rstudio.deb https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2021.09.0-351-amd64.deb &&\
#     dpkg -i rstudio.deb

COPY assets /usr/local/share/assets

COPY condarc_append.txt /tmp/
RUN cat condarc_append.txt > /opt/conda/.condarc

COPY jupyter_config_append.py /tmp/
RUN cat jupyter_config_append.py >> /etc/jupyter/jupyter_notebook_config.py

## Add some nice-looking themes from GitHub
RUN pip install theme-darcula catppuccin-jupyterlab

## Perform cleanup
RUN rm -rf /tmp/* &&\
    npm cache clean --force &&\
    mamba clean --all -f -y

## Return to base-notebook default user
RUN chown -R jovyan /home/jovyan
USER jovyan
WORKDIR /home/jovyan
