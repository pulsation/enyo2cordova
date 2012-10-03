#!/bin/bash

# Load configuration
source config/config.sh

# Initialize HTML5 projects
echo "Initializing ${HTML5_FRAMEWORK} project."
source bin/init-html5-${HTML5_FRAMEWORK}.sh

# Initialize mobile targets
for mobile_target in ${MOBILE_TARGETS}; do
    echo "Initializing ${mobile_target} target."
    source bin/init-${mobile_target}.sh
done;
