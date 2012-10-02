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
    (cd projects/                                                       && \
        git clone ${HTML5_PROJECT_URL} ${HTML5_FRAMEWORK} 2> /dev/null  && \
        cd  ${HTML5_FRAMEWORK}                                          && \
        git submodule init --update)
fi

# initialize git submodules
git submodule init --update

# fetch apache common codecs

mkdir -p ${COMMON_CODEC_DIR}
while [ "$(md5sum ${COMMON_CODEC_DIR}/${COMMON_CODEC_ARCHIVE} 2> /dev/null \
        |cut -d ' ' -f 1)" != "${COMMON_CODEC_MD5}" ]; do
    rm -f ${COMMON_CODEC_DIR}/${COMMON_CODEC_ARCHIVE}
    (cd ${COMMON_CODEC_DIR} && wget -q ${COMMON_CODEC_URL})
done

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

