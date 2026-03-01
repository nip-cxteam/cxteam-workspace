FROM quay.io/jupyter/base-notebook:lab-4.5.4

USER root

WORKDIR /tmp

RUN apt update && apt install -y \
    less openssh-client mosh zstd iputils-ping \
    zsh htop curl git byobu vim squashfs-tools

RUN mamba install -y \
    rclone nb_conda_kernels jupyter-server-proxy seaborn \
    numpy scipy matplotlib pandas zip unzip python-lsp-server \
    jupyterlab_execute_time

## Install gotty
# RUN wget https://github.com/sorenisanerd/gotty/releases/download/v1.6.0/gotty_v1.6.0_linux_amd64.tar.gz  &&\
#     tar xvf gotty_v1.6.0_linux_amd64.tar.gz &&\
#     mv gotty /usr/local/bin/
## Use TTYD instead
RUN wget https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64  &&\
    mv ttyd.x86_64 ttyd &&\
    mv ttyd /usr/local/bin/ &&\
    chmod +x /usr/local/bin/ttyd


## Install code-server
RUN curl -Lk -o code-server.deb https://github.com/coder/code-server/releases/download/v4.109.2/code-server_4.109.2_amd64.deb &&\
    dpkg -i code-server.deb

## Install MS VSCode
RUN wget -O code.tar.gz https://update.code.visualstudio.com/1.109.3/cli-linux-x64/stable &&\
    tar xvf code.tar.gz &&\
    chmod +x code &&\
    mv code /usr/local/bin/

# ## Install Rstudio
# RUN curl -Lkv -o rstudio.deb https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2025.05.1-513-amd64.deb &&\
#     dpkg -i rstudio.deb

COPY assets /usr/local/share/assets

COPY condarc_append.txt /tmp/
RUN cat condarc_append.txt > /opt/conda/.condarc

COPY jupyter_config_append.py /tmp/
RUN cat jupyter_config_append.py >> /etc/jupyter/jupyter_notebook_config.py

## Add some nice-looking themes from GitHub
RUN pip install --no-cache-dir theme-darcula catppuccin-jupyterlab

## Perform cleanup
RUN rm -rf /tmp/* &&\
    mamba clean --all -f -y

## Return to base-notebook default user
RUN chown -R jovyan /home/jovyan
USER jovyan
WORKDIR /home/jovyan
