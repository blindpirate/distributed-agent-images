FROM gradle/gradle-enterprise-test-distribution-agent:1.0

# Switch to root user for installing packages
USER root

RUN mkdir -p /opt/android/sdk/licenses
COPY android-sdk-license /opt/android/licenses/android-sdk-license
ENV ANDROID_HOME=/opt/android
RUN chmod 777 -R /opt/android

RUN ln -s /opt/java/openjdk/bin/java /usr/bin/java

# Install JDK8
RUN set -eux; \
    BINARY_URL='https://d2.injdk.cn/oracle/8/jdk-8u251-linux-x64.tar.gz'; \
    curl -LfsSo /tmp/oraclejdk-8.tar.gz ${BINARY_URL}; \
    mkdir -p /opt/jdk/oraclejdk-8; \
    cd /opt/jdk/oraclejdk-8; \
    tar -xf /tmp/oraclejdk-8.tar.gz --strip-components=1; \
    rm -rf /tmp/oraclejdk-8.tar.gz;

ENV JDK8=/opt/jdk/oraclejdk-8

# Install JDK14
RUN set -eux; \
    ESUM='9ddf9b35996fbd784a53fff3e0d59920a7d5acf1a82d4c8d70906957ac146cd1'; \
    BINARY_URL='https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_x64_linux_hotspot_14.0.1_7.tar.gz'; \
    curl -LfsSo /tmp/openjdk-14.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk-14.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/jdk/openjdk-14; \
    cd /opt/jdk/openjdk-14; \
    tar -xf /tmp/openjdk-14.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk-14.tar.gz;

ENV JDK14=/opt/jdk/openjdk-14

# Install additional packages
ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://security.ubuntu.com/ubuntu xenial-security main" | tee --append /etc/apt/sources.list && \
    apt-get update && apt-get install -y --no-install-recommends \
    wget file git zip \
    unzip \
    g++ \
    g++-multilib \
    gcc-multilib \
    gobjc-multilib \
    gobjc++-multilib \
    clang \
    clang-3.6 \
    libicu-dev \
    libicu55 \
    gnustep-devel \
    make \
    cmake \
    libcurl4-openssl-dev \
    libssl1.0.0 libssl-dev \
    libncurses5-dev \
    lib32ncurses5-dev 

COPY libcurl.so.4.4.0 /usr/lib/x86_64-linux-gnu/libcurl.so.4.4.0
RUN ln -sf /usr/lib/x86_64-linux-gnu/libcurl.so.4.4.0 /usr/lib/x86_64-linux-gnu/libcurl.so.4

COPY libidn.so.11.6.15 /usr/lib/x86_64-linux-gnu/libidn.so.11.6.15
RUN ln -sf /usr/lib/x86_64-linux-gnu/libidn.so.11.6.15 /usr/lib/x86_64-linux-gnu/libidn.so.11
    
RUN mkdir -p /tmp/install-gnustep-libojbc2/
COPY libobjc2-1.6.1.tar.bz2 /tmp/install-gnustep-libojbc2/
COPY install-gnustep-libojbc2.sh /tmp/install-gnustep-libojbc2/

WORKDIR /tmp/install-gnustep-libojbc2/
RUN /tmp/install-gnustep-libojbc2/install-gnustep-libojbc2.sh && rm -rf /tmp/install-gnustep-libojbc2/

RUN mkdir -p /tmp/swift/ && mkdir -p /opt/swift/ && \
    wget https://swift.org/builds/swift-3.1.1-release/ubuntu1604/swift-3.1.1-RELEASE/swift-3.1.1-RELEASE-ubuntu16.04.tar.gz -O /tmp/swift/swift-3.1.1-RELEASE-ubuntu16.04.tar.gz && \
    tar xf /tmp/swift/swift-3.1.1-RELEASE-ubuntu16.04.tar.gz -C /opt/swift/ && mv /opt/swift/swift-3.1.1-RELEASE-ubuntu16.04 /opt/swift/3.1.1 &&\
    wget https://swift.org/builds/swift-4.2.3-release/ubuntu1604/swift-4.2.3-RELEASE/swift-4.2.3-RELEASE-ubuntu16.04.tar.gz -O /tmp/swift/swift-4.2.3-RELEASE-ubuntu16.04.tar.gz && \
    tar xf /tmp/swift/swift-4.2.3-RELEASE-ubuntu16.04.tar.gz -C /opt/swift/ && mv /opt/swift/swift-4.2.3-RELEASE-ubuntu16.04 /opt/swift/4.2.3 && \
    wget https://swift.org/builds/swift-5.0-release/ubuntu1604/swift-5.0-RELEASE/swift-5.0-RELEASE-ubuntu16.04.tar.gz -O /tmp/swift/swift-5.0-RELEASE-ubuntu16.04.tar.gz && \
    tar xf /tmp/swift/swift-5.0-RELEASE-ubuntu16.04.tar.gz -C /opt/swift/ && mv /opt/swift/swift-5.0-RELEASE-ubuntu16.04 /opt/swift/5.0 &&\
    ln -s /opt/swift/5.0 /opt/swift/latest && \
    chmod o+r -R /opt/swift && \
    rm -rf /tmp/swift/

# Switch back to application user
USER gradle
