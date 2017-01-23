FROM openjdk:8-jdk
MAINTAINER Raphael Bialon <bialon@cs.uni-duesseldorf.de>

ENV DEBIAN_FRONTEND noninteractive
ENV ANDROID_HOME  /opt/android
ENV ANDROID_NDK_HOME ${ANDROID_HOME}/ndk-bundle
ENV GRADLE_USER_HOME /cache/.gradle
ENV ANDROID_TOOLS https://dl.google.com/android/repository/tools_r25.2.3-linux.zip

# Install tools for NDK building
RUN apt-get -qq update && apt-get -yqq install build-essential lib32stdc++6 file

# Install Android SDK Manager and necessary components
WORKDIR $ANDROID_HOME
RUN curl -L $ANDROID_TOOLS --output android-tools.zip\
    && unzip android-tools.zip\
    && rm android-tools.zip

RUN echo y | ./tools/bin/sdkmanager "build-tools;25.0.2"
RUN ./tools/bin/sdkmanager "build-tools;24.0.3"
RUN ./tools/bin/sdkmanager "tools"
RUN ./tools/bin/sdkmanager "platform-tools"
RUN ./tools/bin/sdkmanager "ndk-bundle"
RUN ./tools/bin/sdkmanager "platforms;android-25"
RUN ./tools/bin/sdkmanager "platforms;android-24"
RUN ./tools/bin/sdkmanager "extras;android;m2repository"
RUN ./tools/bin/sdkmanager --update

WORKDIR /build
