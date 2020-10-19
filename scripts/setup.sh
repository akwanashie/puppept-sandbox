#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

docker-compose -f $DIR/../docker/docker-compose.yml down -v || true
rm -rf $DIR/../docker/volumes $DIR/../docker/postgres-custom

export DOMAIN=akwanashie && docker-compose -f $DIR/../docker/docker-compose.yml up -d
sleep 60
docker exec -it puppetagent puppet ssl bootstrap