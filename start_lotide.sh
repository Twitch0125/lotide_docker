#!/bin/bash
echo "starting lotidedb"
docker start lotidedb
echo "starting lotide"
docker start lotide
echo "lotide available on localhost:3333/api"