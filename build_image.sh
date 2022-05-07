#!/bin/bash
# Build a docker image from current commit, tag it with the commit hash
# and push to registry.
#
# Takes image name from current working directory.

# Log-in to github registry safely
# eval $(pass github/tokens/registry | tail -n 1)

# Log-in to dockerhub registry safely
eval $(pass dockerhub/cli_login)

owner="qirpi"
image_name=$(pwd | rev | cut -d '/' -f 1 | rev)
commit_hash=$(git rev-parse --short HEAD)

echo "\n"
echo "building image from $commit_hash"
echo "\n"

docker build -t "$image_name:$commit_hash" .
docker tag "$image_name:$commit_hash" "$owner/$image_name:$commit_hash"

docker push "$owner/$image_name:$commit_hash" \
&& echo "successfully pushed $owner/$image_name:$commit_hash to dockerhub"
