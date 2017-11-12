#!/bin/bash

set -euxo pipefail

DIST_DIR="/build/RPMs/x86_64"
VERSION=$1
TARGET=$2

docker build . -f "docker/${VERSION}/${TARGET}/Dockerfile" --rm --tag "xmind-rpm-${VERSION}-${TARGET}"
mkdir -p docker/dist
docker run --rm -v `pwd`/docker/dist:"${DIST_DIR}" -e LOCAL_USER_ID=`id -u $USER` xmind-rpm-${VERSION}-${TARGET}
