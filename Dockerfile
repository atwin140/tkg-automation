FROM ubuntu:24.10

RUN  apt-get update \
    && apt-get install unzip wget curl sudo bash vim jq git dnsutils -y


# Create my user, give sudo and set PS vars.
ARG USERNAME=testuser
ARG UID=1001
ARG GID=1001
RUN groupadd -g $GID -o $USERNAME;  useradd -m -u $UID -g $GID -o -s /bin/bash $USERNAME
RUN useradd -ms /bin/bash ${USERNAME}; echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers; \
    echo 'export PS1="\u@\h \w> # "' >> /root/.bashrc ; \
    echo 'export PS1="\u@\h \w> $ "' >> /home/${USERNAME}/.bashrc ; \
    echo "export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin'">> /home/${USERNAME}/.bashrc

USER root

COPY install2.sc /tmp/install.sc
COPY install2.sh /tmp/install.sh
COPY kubeseal-0.29.0-linux-amd64.tar.gz /tmp/kubeseal.tar.gz
COPY kube-ps1.sh /tmp/kube-ps1.sh
RUN  chmod +x /tmp/install.sh && mkdir /GIT
# RUN  /tmp/install.sh


RUN apt-get clean \
 && update-ca-certificates \
 && rm -f /etc/apt/apt.conf.d/99sres-cert \
 && rm -f /etc/apt/auth.conf.d/auth.conf \
 && rm -rf /var/lib/apt/lists/*


USER $UID
WORKDIR /home/$USERNAME

ENTRYPOINT ["/usr/bin/env", "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin"]
