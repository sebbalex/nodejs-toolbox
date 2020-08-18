FROM ubuntu:latest AS base


WORKDIR /devops

FROM base AS requirements

# Install requirements
RUN apt update \
 && apt install -y -q \
            bash-completion \
            tree \
            curl \
            git \
            gcc \
            make \
            unzip \
            vim

# Configure completion
RUN mkdir -p /etc/bash_completion.d/
RUN echo "source /usr/share/bash-completion/bash_completion" >> ~/.bashrc

FROM requirements AS nodenv

RUN git clone https://github.com/nodenv/nodenv.git ~/.nodenv
RUN cd ~/.nodenv && src/configure && make -C src
RUN echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc

FROM nodenv AS nvm

ENV NVM v0.35.3
ENV NVM_DIR /root/.nvm
ENV NODE_VERSION_12 v12.18.3
ENV NODE_VERSION $NODE_VERSION_12

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM}/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH

FROM nvm AS deno

RUN curl -fsSL https://deno.land/x/install/install.sh | sh
ENV PATH      /root/.deno/bin:$PATH

FROM deno AS yarn

RUN npm install -g yarn

FROM yarn AS ncu

RUN npm install -g npm-check-updates
