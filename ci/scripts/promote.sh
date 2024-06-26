#!/bin/bash
set -euo pipefail

# shellcheck source=scripts/common.sh
source $(dirname $0)/common.sh

version=$(cat artifactory/build-info.json | jq -r '.buildInfo.modules[0].id' | sed 's/.*:.*:\(.*\)/\1/')
export BUILD_INFO_LOCATION=$(pwd)/artifactory/build-info.json

java -jar /concourse-release-scripts*.jar promote $RELEASE_TYPE $BUILD_INFO_LOCATION

echo "Promotion complete"
echo $version >version/version
