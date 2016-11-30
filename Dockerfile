FROM java:8

RUN apt-get --quiet update --yes \
    && apt-get --quiet install --yes lib32stdc++6 lib32z1 \
    && wget --quiet --output-document=android-sdk.tgz https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz \
    && tar --extract --gzip --file=android-sdk.tgz \
    && echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter platform-tools,tools,build-tools-23.0.3,android-23,build-tools-25,android-25,extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services \
    && export ANDROID_HOME=$PWD/android-sdk-linux \
    && mkdir $ANDROID_HOME/licenses \
    && echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > $ANDROID_HOME/licenses/android-sdk-license
