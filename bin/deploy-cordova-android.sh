#!/bin/bash

# Load configuration
source config/config.sh

# Remove existing www project in cordova
rm -rf ${ANDROID_PROJECT_DIR}/assets/www

# Deploy enyo project into cordova
(cd ${HTML5_PROJECT_DIR} && TARGET=${ENYO2CORDOVA_DIR}/${ANDROID_PROJECT_DIR}/assets/www bash tools/deploy.sh -o ${ENYO2CORDOVA_DIR}/${ANDROID_PROJECT_DIR}/assets/www)

cp ${CORDOVA_ANDROID_DIR}/framework/assets/js/cordova.android.js ${ANDROID_PROJECT_DIR}/assets/www/build/cordova.js

# Generate APK and install on device if connected
(cd ${ANDROID_PROJECT_DIR} && cordova/debug)
