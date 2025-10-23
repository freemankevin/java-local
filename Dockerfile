FROM public.ecr.aws/amazoncorretto/amazoncorretto:8

LABEL maintainer="https://github.com/freemankevin/java-local"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai

RUN yum update -y && \
    yum install -y \
    tzdata \
    curl \
    wget \
    net-tools \
    iputils \
    telnet \
    bind-utils \
    libreoffice \
    libreoffice-langpack-zh_CN \
    google-noto-sans-cjk-fonts \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && yum clean all && \
    rm -rf /var/cache/yum/*

# 确保 SSL 证书已更新
RUN update-ca-trust
