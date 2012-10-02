#!/bin/bash

# Load configuration
source config/cordova.conf
source config/html5-project.conf

# check utility dependancies and configuration
if [ ! `which git` ]; then
    echo "git is needed to proceed." >&2;
    exit 1
fi

# checkout html5 project 
if [ "${HTML5_PROJECT_SCM}" = "git" ]; then
    (cd projects/                                                           && \
        git clone ${HTML5_PROJECT_GIT_URL} ${HTML5_FRAMEWORK} 2> /dev/null  && \
        cd  ${HTML5_FRAMEWORK}                                              && \
        git checkout ${HTML5_PROJECT_GIT_BRANCH}                            && \
        git submodule update --init)
fi

# initialize git submodules
git submodule update --init

