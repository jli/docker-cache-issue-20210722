#!/bin/bash

set -euo pipefail

DOCKER_BUILDKIT=1
docker system prune -a -f

# using docker-container driver per https://github.com/moby/buildkit/issues/1981#issuecomment-785534131
docker buildx create --driver docker-container --name cache-bug-workaround
docker buildx build --builder cache-bug-workaround --load \
    -t circularly/docker-cache-issue-20210722:cachebug-containerdriver \
    --cache-from circularly/docker-cache-issue-20210722:cachebug-containerdriver \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    .
docker buildx rm --builder cache-bug-workaround
docker push circularly/docker-cache-issue-20210722:cachebug-containerdriver

# this causes a change in the local files to simulate a code-only change
date > date_log.txt
