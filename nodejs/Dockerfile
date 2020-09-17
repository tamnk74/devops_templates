FROM node:12.13.0-alpine

RUN apk update && apk add bash && apk add python && apk add make && npm install -g loopback-cli && npm install -g nodemon && npm install -g node-pre-gyp

USER root

# Set default work directory
WORKDIR /var/www