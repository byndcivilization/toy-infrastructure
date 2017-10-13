#!/usr/bin/env bash
#
#  Build and push a new version of the base python2 image
#

REGISTRY="us.gcr.io/civis-demo-181920/"
IMAGE="node6"
# VERSION="6.9"

gcloud components install alpha

echo "Building remotely using gcloud container builder..."
echo "If this fails, please ensure you have gcloud alpha components installed,"
echo "or try building locally with docker."

####################################
# Build using Google Cloud Builder #
####################################
gcloud alpha container builds create . --tag ${REGISTRY}${IMAGE}:latest

#################
# Build locally #
#################
#gcloud docker -a
#docker build --rm -t ${REGISTRY}${IMAGE}:${VERSION} .
#docker push ${REGISTRY}${IMAGE}:${VERSION}
#docker tag  ${REGISTRY}${IMAGE}:${VERSION} ${REGISTRY}${IMAGE}:latest
#docker push ${REGISTRY}${IMAGE}:latest

