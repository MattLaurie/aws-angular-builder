FROM node:10

RUN apt-get update && \
	apt-get install -y python python-pip python-dev

ENV ANGULAR_CLI_VERSION=8.1.2
RUN npm install -g \
	@angular/cli@${ANGULAR_CLI_VERSION}

ENV AWSCLI_VERSION=1.16.207
RUN pip install awscli==${AWSCLI_VERSION}
