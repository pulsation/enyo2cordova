#!/bin/bash

# fetch cordova ios sources
git clone ${CORDOVA_IOS_GIT_URL} ${CORDOVA_IOS_DIR}
(cd ${CORDOVA_IOS_DIR} && git checkout ${CORDOVA_IOS_GIT_BRANCH})

# create ios android project
(cd ${CORDOVA_IOS_DIR} && \
    ./bin/create ../../../${IOS_PROJECT_DIR} ${PACKAGE_NAME} ${PROJECT_NAME})

