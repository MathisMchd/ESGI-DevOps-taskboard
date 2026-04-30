#!/bin/sh

set -e

IMAGE_TAG=$1
if [ -z "$IMAGE_TAG" ]; then
  echo "Usage: $0 <image_tag>"
  exit 1
fi

CONTAINER_NAME="taskboard-app"

echo "Stopping and removing existing container if it exists..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "Pulling image: $IMAGE_TAG"
docker pull $IMAGE_TAG

echo "Running new container..."
docker run -d --name $CONTAINER_NAME -p 3000:3000 $IMAGE_TAG

echo "Waiting for application to start..."
sleep 10

echo "Performing healthcheck..."
if curl -f http://localhost:3000 > /dev/null 2>&1; then
  echo "Healthcheck passed. Deployment successful."
else
  echo "Healthcheck failed. Deployment failed."
  exit 1
fi