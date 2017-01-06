FROM openjdk:8-jdk
MAINTAINER Raphael Bialon <bialon@cs.uni-duesseldorf.de>

ENV DEBIAN_FRONTEND noninteractive
ENV ANDROID_HOME  /opt/android
ENV ANDROID_TOOLS https://dl.google.com/android/repository/tools_r25.2.3-linux.zip
ENV GRADLE_VERSION 2.14.1
ENV PATH ${PATH}:/usr/local/gradle/bin

# Install Android SDK Manager and necessary components
WORKDIR $ANDROID_HOME
RUN curl -L $ANDROID_TOOLS --output android-tools.zip\
    && unzip android-tools.zip\
    && rm android-tools.zip
RUN echo y | ./tools/bin/sdkmanager "build-tools;25.0.0"\
    && ./tools/bin/sdkmanager "build-tools;24.0.0"\
    && ./tools/bin/sdkmanager "tools"\
    && ./tools/bin/sdkmanager "platform-tools"\
    && ./tools/bin/sdkmanager "ndk-bundle"\
    && ./tools/bin/sdkmanager "platforms;android-25"\
    && ./tools/bin/sdkmanager "platforms;android-24"\
    && ./tools/bin/sdkmanager --update

# Install gradle
WORKDIR /usr/local
RUN curl -L https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip --output gradle.zip\
    && unzip gradle.zip\
    && rm gradle.zip\
    && ln -s gradle-$GRADLE_VERSION gradle
