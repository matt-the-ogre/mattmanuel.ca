#!/bin/bash

# Remove existing container if it exists
docker rm -f mattmanuel-test 2>/dev/null || true

# Run new container
docker run -d -p 8080:8000 --name mattmanuel-test mattmanuel-site

echo "Container started! Site available at http://localhost:8080"
read -p "Open site in browser? [Y/n]: " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    open http://localhost:8080
fi