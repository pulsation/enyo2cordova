#!/bin/bash

# Load configuration
source config/config.sh

# Remove existing www project in cordova
rm -rf ${IOS_PROJECT_DIR}/www

# Deploy enyo project into cordova
(cd ${HTML5_PROJECT_DIR}/tools && TARGET=${ENYO2CORDOVA_DIR}/${IOS_PROJECT_DIR}/www bash deploy.sh)

cp ${CORDOVA_IOS_DIR}/CordovaLib/javascript/cordova.ios.js ${IOS_PROJECT_DIR}/www/build/cordova.js

# Generate APK and install on device if connected
(cd ${IOS_PROJECT_DIR} && cordova/debug)
