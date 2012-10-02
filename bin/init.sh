#!/bin/bash

# Load configuration
source config/cordova.conf
source config/html5-project.conf

# check utility dependancies and configuration
if [ ! `which git` ]; then
    echo "git is needed to proceed." >&2;
    exit 1
fi

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

# add html5 project 
if [ "${HTML5_PROJECT_SCM}" = "git" ]; then
    mkdir -p projects/${HTML5_FRAMEWORK}    && \
    (cd projects/${HTML5_FRAMEWORK}         && \
        git clone ${HTML5_PROJECT_URL})     && \
    (cd projects/${HTML5_FRAMEWORK}         && \
    git submodule init                      && \
    git submodule update)
fi

# initialize git submodules
git submodule init && git submodule update

# fetch apache common codecs

mkdir -p ${COMMON_CODEC_DIR}
checksum=$(md5sum ${COMMON_CODEC_DIR}/${COMMON_CODEC_ARCHIVE}|cut -d ' ' -f 1)

if [ "${checksum}" != "${COMMON_CODEC_MD5}" ]; then
    (cd ${COMMON_CODEC_DIR} && wget -q ${COMMON_CODEC_URL})
fi

# untar it
(cd ${COMMON_CODEC_DIR} && tar xvzf ${COMMON_CODEC_ARCHIVE})

# copy it to corodva
(mkdir -p ${CORDOVA_ANDROID_DIR}/framework/libs/ && \
cp ${COMMON_CODEC_DIR}/commons-codec-${COMMON_CODEC_VERSION}/commons-codec-${COMMON_CODEC_VERSION}.jar \
${CORDOVA_ANDROID_DIR}/framework/libs/)

# Build the phonegap jar lib
(cd ${CORDOVA_ANDROID_DIR}/framework && \
    android update project -p . -t android-${CORDOVA_ANDROID_VERSION} && ant jar)

# Install dependancies
(cd ${CORDOVA_ANDROID_DIR}/bin && \
    npm install)

# create cordova android project
(cd ${CORDOVA_ANDROID_DIR} && \
    ./bin/create ../../../${ANDROID_PROJECT_DIR})

