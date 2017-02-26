#!/bin/bash

AWSCLI_CURRENT=`grep "ENV AWSCLI_VERSION=" Dockerfile | cut -c 20-`
ANGULAR_CLI_CURRENT=`grep "ENV ANGULAR_CLI_VERSION=" Dockerfile | cut -c 25-`

AWSCLI_LATEST=`wget -qO- https://pypi.python.org/pypi/awscli/json | grep -E ' {8}"[0-9."]*": \[' | sort -V | tail -n 1 | tr -d ' ":['`
ANGULAR_CLI_LATEST=`npm view @angular/cli version`

if [[ "$AWSCLI_CURRENT" != "$AWSCLI_LATEST" ]] || [[ "$ANGULAR_CLI_CURRENT" != "$ANGULAR_CLI_LATEST" ]]; then
  if [[ "$ANGULAR_CLI_CURRENT" != "$ANGULAR_CLI_LATEST" ]]; then
	echo "Angular CLI	$ANGULAR_CLI_CURRENT -> $ANGULAR_CLI_LATEST"
  fi
  if [[ "$AWSCLI_CURRENT" != "$AWSCLI_LATEST" ]]; then
	echo "AWS CLI		$AWSCLI_CURRENT -> $AWSCLI_LATEST"
  fi
  echo "Run \"check-update.sh -u\" to update the Dockerfile"
fi

if [ "$1" = "-u" ]; then
  sed -i "s/ENV AWSCLI_VERSION=.*/ENV AWSCLI_VERSION=$AWSCLI_LATEST/g" Dockerfile
  sed -i "s/ENV ANGULAR_CLI_VERSION=.*/ENV ANGULAR_CLI_VERSION=$ANGULAR_CLI_LATEST/g" Dockerfile
  echo "Updated Dockerfile with latest versions"
fi
