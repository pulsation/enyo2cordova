#!/bin/bash

# Load configuration
source config/config.sh

# deploy to mobile targets
for mobile_target in ${MOBILE_TARGETS}; do
    echo "Deploying to ${mobile_target}."
    source bin/deploy-${mobile_target}.sh
done;