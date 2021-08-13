#!/bin/bash
echo "Creating network lotide"
docker network create lotide
echo "Creating volume lotidedb"
docker volume create lotidedb
echo "Creating postgres container lotidedb "
docker run --name lotidedb --network=lotide -d -e POSTGRES_PASSWORD=lotide -e POSTGRES_DB=lotidedb -e POSTGRES_USER=lotide   -v lotidedb:/var/lib/postgresql/data postgres
echo "Doing setup migrations"
sleep 5
docker run --name lotide-migrate-setup --rm --network=lotide  -e RUST_BACKTRACE=1 -e HOST_URL_ACTIVITYPUB=http://localhost:3333/apub -e HOST_URL_API=http://localhost:3333/api -e DATABASE_URL=postgresql://lotide:lotide@lotidedb:5432/lotidedb lotide/lotide lotide migrate setup
docker run --name lotide-migrate --rm --network=lotide -e RUST_BACKTRACE=1 -e HOST_URL_ACTIVITYPUB=http://localhost:3333/apub -e HOST_URL_API=http://localhost:3333/api -e DATABASE_URL=postgresql://lotide:lotide@lotidedb:5432/lotidedb lotide/lotide lotide migrate
echo "Starting Lotide"
docker run  --name lotide -p 3333:3333 -d --network=lotide -e RUST_BACKTRACE=1 -e HOST_URL_ACTIVITYPUB=http://localhost:3333/apub -e HOST_URL_API=http://localhost:3333/api -e DATABASE_URL=postgresql://lotide:lotide@lotidedb/lotidedb lotide/lotide
echo "Lotide available on http://localhost:3333/api" 