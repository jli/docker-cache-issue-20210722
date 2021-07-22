#!/bin/bash

set -euo pipefail

DOCKER_BUILDKIT=1
docker system prune -a -f

docker build \
    -t circularly/docker-cache-issue-20210722:cachebug \
    --cache-from circularly/docker-cache-issue-20210722:cachebug \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    .

docker push circularly/docker-cache-issue-20210722:cachebug

# this causes a change in the local files to simulate a code-only change
date > date_log.txt
