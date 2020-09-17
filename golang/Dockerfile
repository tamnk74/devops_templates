FROM golang:alpine

# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache bash git openssh

USER root

# Set default work directory
WORKDIR /var/www