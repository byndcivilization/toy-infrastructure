FROM node:6.9
MAINTAINER Chris Perry, cperry@advisorconnect.co

# Upgrade system
RUN		apt-get autoremove -y
RUN 	apt-get update -y \
   		&& apt-get upgrade -y \
   		&& apt-get clean -y

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install dependancies
RUN		npm install -g forever

# Allow for new requirements to be added when a subsequent build occurs
ONBUILD COPY package.json /usr/src/app/
ONBUILD RUN  npm install --production

# Copy source into the app folder
ONBUILD COPY . /usr/src/app


LABEL co.advisorconnect.image=gcr.io/civis-demo-181920/node6