FROM bellsoft/liberica-openjdk-debian:8-cds

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
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && rm -rf /var/lib/apt/lists/*