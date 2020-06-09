FROM gradle/gradle-enterprise-test-distribution-agent:1.0

# Switch to root user for installing packages
USER root

# Install JDK8
RUN set -eux; \
    ESUM='f39b523c724d0e0047d238eb2bb17a9565a60574cf651206c867ee5fc000ab43'; \
    BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u242-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u242b08.tar.gz'; \
    curl -LfsSo /tmp/openjdk-8.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk-8.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/jdk/openjdk-8; \
    cd /opt/jdk/openjdk-8; \
    tar -xf /tmp/openjdk-8.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk-8.tar.gz;

ENV JDK8=/opt/jdk/openjdk-8

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
RUN apt-get update && apt-get install -y --no-install-recommends zip \
    unzip \
    g++ \
    g++-multilib \
    gcc-multilib \
    gobjc-multilib \
    gobjc++-multilib \
    clang-3.6 \
    gnustep-devel \
    make \
    cmake \
    libcurl4-openssl-dev \
    libncurses5-dev \
    lib32ncurses5-dev 
    
RUN mkdir -p /tmp/install-gnustep-libojbc2/
COPY libobjc2-1.6.1.tar.bz2 /tmp/install-gnustep-libojbc2/
COPY install-gnustep-libojbc2.sh /tmp/install-gnustep-libojbc2/

WORKDIR /tmp/install-gnustep-libojbc2/
RUN /tmp/install-gnustep-libojbc2/install-gnustep-libojbc2.sh

# Switch back to application user
USER gradle
