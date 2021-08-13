#!/bin/bash
docker container stop lotide
docker container stop lotidedb
docker container rm lotide
docker container rm lotidedb
docker network rm lotide
docker volume rm lotidedb
