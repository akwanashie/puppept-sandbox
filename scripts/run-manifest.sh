#! /usr/bin/env bash

MANIFEST_FILE=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
MANIFEST_DIR=$DIR/../docker/volumes/code/environments/production/manifests

mkdir -p $MANIFEST_DIR
cp $MANIFEST_FILE $MANIFEST_DIR

docker exec -it puppetagent puppet agent -tv --logdest /agent-data/output.json