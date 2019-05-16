#!/bin/bash

AWSCLI_CURRENT=`grep "ENV AWSCLI_VERSION=" Dockerfile | cut -c 20-`
ANGULAR_CLI_CURRENT=`grep "ENV ANGULAR_CLI_VERSION=" Dockerfile | cut -c 25-`

AWSCLI_LATEST=`curl -s https://pypi.org/pypi/awscli/json | jq -r '.urls[] | .filename | select(. | endswith("gz"))' | grep -oP 'awscli-\K.*(?=\.tar\.gz)'`
ANGULAR_CLI_LATEST=`npm view @angular/cli version`

echo "Checking for updates"
if [[ "$AWSCLI_CURRENT" != "$AWSCLI_LATEST" ]] || [[ "$ANGULAR_CLI_CURRENT" != "$ANGULAR_CLI_LATEST" ]]; then
  if [[ "$ANGULAR_CLI_CURRENT" != "$ANGULAR_CLI_LATEST" ]]; then
	echo "Angular CLI	$ANGULAR_CLI_CURRENT -> $ANGULAR_CLI_LATEST"
  else
    echo "Angular CLI	$ANGULAR_CLI_CURRENT"
  fi
  if [[ "$AWSCLI_CURRENT" != "$AWSCLI_LATEST" ]]; then
	echo "AWS CLI		$AWSCLI_CURRENT -> $AWSCLI_LATEST"
  else
	echo "AWS CLI		$AWSCLI_CURRENT"
  fi
  echo "Run \"check-update.sh -u\" to update the Dockerfile"
else
  echo "Angular CLI	$ANGULAR_CLI_CURRENT"
  echo "AWS CLI		$AWSCLI_CURRENT"
  echo "All Dockerfile versions up to date"
fi

if [ "$1" = "-u" ]; then
  sed -i "s/ENV AWSCLI_VERSION=.*/ENV AWSCLI_VERSION=$AWSCLI_LATEST/g" Dockerfile
  sed -i "s/ENV ANGULAR_CLI_VERSION=.*/ENV ANGULAR_CLI_VERSION=$ANGULAR_CLI_LATEST/g" Dockerfile
  echo "Updated Dockerfile with latest versions"
fi
