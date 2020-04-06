#!/bin/bash

# echo "FROM buildpack-deps:$(awk -F'_' '{print tolower($2)}' <<< $LINUX_VERSION)"
echo "FROM circleci/node:12.16.1"
echo "RUN sudo apt-get update"
echo "RUN sudo apt-get -y install zip lsb-release unzip python-dev python-pip"
echo "ENV AWS_CLI_VERSION=2.0.6"
echo "RUN curl -sSL \"https://awscli.amazonaws.com/awscli-exe-linux-x86_64-\${AWS_CLI_VERSION}.zip\" -o \"aws-cli.zip\" && \
	unzip aws-cli.zip && \
	sudo ./aws/install && \
	rm -r aws-cli.zip aws && \
	aws --version"
echo "RUN sudo apt-get update && sudo apt-get install \
		python3 \
		python3-pip \
    && \
    sudo rm -rf /var/lib/apt/lists/* && \
    pip3 --no-cache-dir install awsebcli && \
    eb --version"
  
if [ $MYSQL_CLIENT = "true" ] ; then
    echo "RUN sudo apt-get -y install mysql-client"
fi

if [ $POSTGRES_CLIENT = "true" ] ; then
    echo "RUN sudo apt-get -y install postgresql-client"
fi