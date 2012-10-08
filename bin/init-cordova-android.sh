#!/bin/bash

if [ ! `which wget` ]; then
    echo "wget is needed to proceed." >&2;
    exit 1
fi

if [ ! `which npm` ]; then
    echo "npm is needed to proceed." >&2;
    exit 1
fi

if [ ! `which android` ]; then
    echo "android is needed to proceed." >&2;
    exit 1
fi

if [ ! `which ant` ]; then
    echo "ant is needed to proceed." >&2;
    exit 1
fi

# fetch cordova android sources
git clone ${CORDOVA_ANDROID_GIT_URL} ${CORDOVA_ANDROID_DIR}
(cd ${CORDOVA_ANDROID_DIR} && git checkout ${CORDOVA_ANDROID_GIT_BRANCH})

# fetch apache common codecs

mkdir -p ${COMMON_CODEC_DIR}
while [ "$(md5sum ${COMMON_CODEC_DIR}/${COMMON_CODEC_ARCHIVE} 2> /dev/null \
        |cut -d ' ' -f 1)" != "${COMMON_CODEC_MD5}" ]; do
    rm -f ${COMMON_CODEC_DIR}/${COMMON_CODEC_ARCHIVE}
    (cd ${COMMON_CODEC_DIR} && wget ${COMMON_CODEC_URL})
done

# untar it
(cd ${COMMON_CODEC_DIR} && tar xzf ${COMMON_CODEC_ARCHIVE})

# copy it to corodva
(mkdir -p ${CORDOVA_ANDROID_DIR}/framework/libs/ && \
cp ${COMMON_CODEC_DIR}/commons-codec-${COMMON_CODEC_VERSION}/commons-codec-${COMMON_CODEC_VERSION}.jar \
${CORDOVA_ANDROID_DIR}/framework/libs/)

# Build the phonegap jar lib
(cd ${CORDOVA_ANDROID_DIR}/framework && \
    android update project -p . -t android-${CORDOVA_ANDROID_VERSION} --subprojects && ant jar)

# Install dependancies
(cd ${CORDOVA_ANDROID_DIR}/bin && \
    npm install)

# create cordova android project
(cd ${CORDOVA_ANDROID_DIR} && \
    ./bin/create ../../../${ANDROID_PROJECT_DIR} ${PACKAGE_NAME} ${PROJECT_NAME})

