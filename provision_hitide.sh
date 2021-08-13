#!/bin/bash
echo "Starting Hitide"
docker run  --name hitide -p 4333:4333 -d --network=lotide  -e BACKEND_HOST=http://lotide:3333 lotide/hitide
echo "Hitide available on http://localhost:4333"