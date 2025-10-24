FROM --platform=$BUILDPLATFORM debian:12.12 AS builder
ARG BUILDPLATFORM
ARG TARGETPLATFORM
ARG TARGETARCH

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai

WORKDIR /tmp

# 根据目标架构下载对应的JDK
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

RUN if [ "$TARGETARCH" = "arm64" ]; then \
      curl -L -o jdk.tar.gz "https://github.com/hmsjy2017/get-jdk/releases/download/v8u231/jdk-8u231-linux-arm64-vfp-hflt.tar.gz"; \
    else \
      curl -L -o jdk.tar.gz "https://github.com/hmsjy2017/get-jdk/releases/download/v8u231/jdk-8u231-linux-x64.tar.gz"; \
    fi && \
    tar -xzf jdk.tar.gz && \
    mkdir -p /jdk8 && \
    mv /tmp/jdk1.8.0_231/* /jdk8/

# 最终镜像
FROM debian:12.12
LABEL maintainer="https://github.com/freemankevin/java-local"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai \
    JAVA_HOME=/usr/local/jdk8 \
    PATH=/usr/local/jdk8/bin:$PATH

# 复制JDK从builder阶段
COPY --from=builder /jdk8 /usr/local/jdk8

# 安装依赖
RUN apt-get update && apt-get install -y \
    tzdata \
    curl \
    iputils-ping \
    dnsutils \
    libreoffice \
    libreoffice-l10n-zh-cn \
    libreoffice-help-zh-cn \
    fonts-noto-cjk \
    ca-certificates \
    && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo Asia/Shanghai > /etc/timezone \
    && rm -rf /var/lib/apt/lists/* \
    && update-ca-certificates

# 验证Java安装
RUN java -version && javac -version