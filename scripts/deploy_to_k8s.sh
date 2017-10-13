#!/bin/bash

set -e
REGISTRY="us.gcr.io/civis-demo-181920/"
IMAGE="flask-app-civis"
#set image tag
IMAGE_TAG=${CI_BRANCH}-${CI_TIMESTAMP}-${CI_COMMIT_ID}-${CI_COMMITTER_USERNAME}

# authenticate and update google cloud
codeship_google authenticate
gcloud components update --quiet

# set compute zone
gcloud config set compute/zone us-east1-b

# set kubernetes cluster
gcloud container clusters get-credentials london

echo deploying image: ${IMAGE}:${IMAGE_TAG}
# update kubernetes Deployment
GOOGLE_APPLICATION_CREDENTIALS=/keyconfig.json \
    kubectl set image deployment/flask-app-civis-${CI_BRANCH} \
    --namespace=civis-${CI_BRANCH} \
    flask-app-civis-$CI_BRANCH=${REGISTRY}${IMAGE}:${IMAGE_TAG}