FROM java:8

RUN apt-get --quiet update --yes \
    && apt-get --quiet install --yes lib32stdc++6 lib32z1 unzip

RUN mkdir android-sdk
ENV ANDROID_HOME $PWD/android-sdk

RUN wget --quiet --output-document=sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip?hl=ja \
    && unzip sdk-tools.zip -d $ANDROID_HOME/
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/tools/bin

RUN mkdir $ANDROID_HOME/licenses \
    && echo "8933bad161af4178b1185d1a37fbf41ea5269c55\n\nd56f5187479451eabf01fb78af6dfcb131a6481e" > $ANDROID_HOME/licenses/android-sdk-license

RUN sdkmanager --verbose "extras;android;m2repository" "tools" "platform-tools" "extras;google;m2repository" "extras;google;google_play_services" "platforms;android-26" "build-tools;26.0.2"

ADD ./ ./