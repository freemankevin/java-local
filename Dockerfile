FROM public.ecr.aws/amazoncorretto/amazoncorretto:8

LABEL maintainer="https://github.com/freemankevin/java-local"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN apt-get update && apt-get install -y \
    tzdata \
    curl \
    net-tools \
    iputils-ping \
    software-properties-common \
    fonts-noto-cjk \
    libreoffice \
    libreoffice-l10n-zh-cn \
    libreoffice-help-zh-cn \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && rm -rf /var/lib/apt/lists/*
