FROM nuagebec/ubuntu:16.04                                                                                                                                                                                              
LABEL maintainer "Ariel Kuechler <github.ariel@kuechler.info>"

RUN export HOME_DIR=/root

RUN apt-get update -y \
  && apt-get -y upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    autoconf automake build-essential libass-dev libfreetype6-dev \                                                        
    libsdl2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev \                                                                                                                  
    libxcb-xfixes0-dev pkg-config texinfo zlib1g-dev cmake mercurial nasm tmux \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*                                                        

COPY compile.sh ${HOME_DIR}/

RUN chmod u+x ${HOME_DIR}/compile.sh && ${HOME_DIR}/compile.sh

RUN echo "export PATH=\${PATH}:${HOME_DIR}/bin/" >> ${HOME_DIR}/.profile && cat ${HOME_DIR}/.profile
