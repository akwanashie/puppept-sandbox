#! /usr/bin/env bash

docker-compose down -v || true
rm -rf volumes postgres-custom || true

export DOMAIN=akwanashie && docker-compose up -d
docker exec -it puppetagent puppet ssl bootstrap