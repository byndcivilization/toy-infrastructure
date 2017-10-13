#!/bin/bash
export GCLOUD_ZONE=us-east1-b
export PROKECT_NS=civis-demo

# CREATE CLUSTER AND ADD TO KC
gcloud auth login
gcloud config set project civis-demo-181920
gcloud container clusters create toy-cluster -z ${GCLOUD_ZONE} -m n1-standard-2
gcloud container clusters get-credentials toy-cluster

#CREATE PERSISTANT DRIVES
gcloud compute disks create civis-postgres-cluster-data-1 --size=20GB --type=pd-ssd --zone=${GCLOUD_ZONE}
gcloud compute disks create civis-postgres-cluster-data-2 --size=20GB --type=pd-ssd --zone=${GCLOUD_ZONE}
gcloud compute disks create civis-postgres-cluster-data-3 --size=20GB --type=pd-ssd --zone=${GCLOUD_ZONE}

# #BUILD BASE IMAGES
# cd ./docker/python3 && bash build.sh && cd ../..
# cd ./docker/node6 && bash build.sh && cd ../..
# cd ./flask-app && bash build.sh && cd ../

#K8S SETUP
kubectl create namespace ${PROKECT_NS}
kubectl create -f ./k8s/00-persistant-volumes.yaml
kubectl create -f ./k8s/01-persistant-volume-claim.yaml
kubectl create -f ./k8s/02-services.yaml
kubectl create -f ./k8s/03-secrets.yaml
kubectl create -f ./k8s/04-postgres-deployment.yaml
kubectl create -f ./k8s/05-redis-deployment.yaml

#PORT FOWARD POSTGRES
kubectl port-forward $(kc get pod --namespace=${PROKECT_NS} | grep civis-demo-postgres | head -n1 | awk '{print $1}') -n ${PROKECT_NS} 5432:5432

bash ./db_init.sh

# create database and user
cd flask-app && python manage.py db init && cd ../
cd flask-app && python manage.py db migrate && cd ../
cd flask-app && python manage.py db upgrade && cd ../

#CREATE APP
kubectl create -f ./k8s/06-flask-app-service.yaml
kubectl create -f ./k8s/07-flask-app-deployment.yaml
kubectl create -f ./k8s/08-flask-app-hpa.yaml








#CLEANUP
# gcloud auth login
# gcloud config set project civis-demo-181920
kubectl config unset users.$(kubectl config view -o json | jq .users |  grep gke_civis-demo | tr -d '"' | tr -d ',' | sed -e 's/.*://')
kubectl config unset contexts.$(kubectl config view -o json | jq .contexts |  grep name | grep gke_civis-demo | tr -d '"' | tr -d ',' | sed -e 's/.*://')
kubectl config unset clusters.$(kubectl config view -o json | jq .clusters  |  grep gke_civis-demo | tr -d '"' | tr -d ',' | sed -e 's/.*://')
gcloud container clusters delete toy-cluster

