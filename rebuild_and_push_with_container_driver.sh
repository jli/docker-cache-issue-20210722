#!/bin/bash

set -euo pipefail

DOCKER_BUILDKIT=1
docker system prune -a -f

# using docker-container driver per https://github.com/moby/buildkit/issues/1981#issuecomment-785534131
docker buildx create --driver docker-container --name cache-fail-workaround
docker buildx build --builder cache-fail-workaround \
    -t circularly/docker-cache-issue-20210722:cachebug \
    --cache-from circularly/docker-cache-issue-20210722:cachebug \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    .
# todo: try commenting this?
docker buildx rm --builder cache-fail-workaround

docker push docker push circularly/docker-cache-issue-20210722:cachebug

# this causes a change in the local files to simulate a code-only change
date > date_log.txt
