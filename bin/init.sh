#!/bin/bash

# Load configuration
source config/config.sh

# Initialize HTML5 projects
for html5_framework in ${HTML5_FRAMEWORKS}; do
    echo "Initializing ${html5_framework} project."
    source bin/init-html5-${html5_framework}.sh
done;

# Initialize mobile targets
for mobile_target in ${MOBILE_TARGETS}; do
    echo "Initializing ${mobile_target} target."
    source bin/init-${mobile_target}.sh
done;
