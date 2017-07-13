FROM node:6

RUN apt-get update && \
	apt-get install -y python python-pip python-dev

ENV ANGULAR_CLI_VERSION=1.2.1
RUN npm install -g \
	@angular/cli@${ANGULAR_CLI_VERSION}

ENV AWSCLI_VERSION=1.11.119
RUN pip install awscli==${AWSCLI_VERSION}
