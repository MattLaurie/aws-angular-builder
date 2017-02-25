FROM node:6

RUN apt-get update && \
	apt-get install -y python python-pip python-dev

ENV AWSCLI_VERSION=1.11.52
RUN pip install awscli==${AWSCLI_VERSION}

ENV ANGULAR_CLI_VERSION=1.0.0-rc.0
RUN npm install -g \
	@angular/cli@${ANGULAR_CLI_VERSION}
