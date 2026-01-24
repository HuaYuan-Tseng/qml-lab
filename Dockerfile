FROM ubuntu:24.04

ARG USER_NAME=dev
ARG USER_UID=1000
ARG USER_GID=1000

ENV DEBIAN_FRONTEND=noninteractive \
    TZ="Asia/Taipei" \
    LANG="en_US.UTF-8" \
    TERM="xterm-256color" \
    USER_NAME=${USER_NAME} \
    HOME=/home/${USER_NAME} \
    XAUTHORITY=/home/${USER_NAME}/.Xauthority

RUN set -eux && \
    echo "========== Installing dependencies ==========" && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
    # --- General Tools ---
    software-properties-common \
    systemd-coredump \
    ca-certificates \
    git \
    git-lfs \
    gnupg2 \
    vim \
    net-tools \
    locales \
    openssh-server \
    kmod \
    bat \
    less \
    moreutils \
    btop \
    fontconfig \
    ripgrep \
    # --- Download and Compression Tools ---
    wget \
    curl \
    zip \
    unzip \
    # --- General Development Tools ---
    python3 \
    python3-pip \
    python3-venv \
    nasm \
    yasm \
    luarocks \
    # --- C++ Development Tools ---
    build-essential \
    automake \
    autoconf \
    pkg-config \
    libtool \
    ninja-build \
    cmake \
    meson \
    m4 \
    llvm \
    ccache \
    clangd \
    clang-format \
    clang-tidy \
    cppcheck \
    valgrind \
    doxygen \
    gdb \
    lcov \
    gcovr \
    # --- Qt ---
    qt6-base-dev \
    qt6-declarative-dev \
    qt6-tools-dev \
    qt6-tools-dev-tools \
    qml6-module-qtquick \
    qml6-module-qtquick-controls \
    qml6-module-qtquick-layouts \
    # --- VNC + XFCE ---
    xfce4 \
    xfce4-terminal \
    dbus-x11 \
    xauth \
    at-spi2-core \
    libnotify-bin \
    pm-utils \
    tightvncserver \
    tigervnc-standalone-server \
    tigervnc-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    echo "========== Setting locale ==========" && \
    locale-gen ${LANG} && \
    update-locale LANG=${LANG} && \
    echo "========== Setting timezone ==========" && \
    ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone

# Use `-build-arg USER_UID=$(id -u) --build-arg USER_GID=$(id -g)` on macOS when building.

RUN (getent group ${USER_GID} || groupadd --gid ${USER_GID} ${USER_NAME}) \
    && useradd -m -u ${USER_UID} -g ${USER_GID} -s /bin/bash ${USER_NAME} \
    && mkdir -p /workspace \
    && chown -R ${USER_UID}:${USER_GID} /workspace \
    && mkdir -p /home/${USER_NAME}/.vnc \
    && printf '#!/bin/sh\nstartxfce4\n' > /home/${USER_NAME}/.vnc/xstartup \
    && chmod +x /home/${USER_NAME}/.vnc/xstartup \
    && chown -R ${USER_UID}:${USER_GID} /home/${USER_NAME}/.vnc

WORKDIR /workspace

EXPOSE 5901

USER ${USER_NAME}

CMD ["bash", "-lc", "if [ -n \"$VNC_PASSWORD\" ]; then mkdir -p \"$HOME/.vnc\" && printf \"%s\\n\" \"$VNC_PASSWORD\" | tigervncpasswd -f > \"$HOME/.vnc/passwd\" && chmod 600 \"$HOME/.vnc/passwd\"; fi; vncserver :1 -geometry 1920x1080 -depth 24 -localhost no && tail -f \"$HOME/.vnc\"/*.log"]

