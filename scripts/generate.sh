#!/bin/bash

# echo "FROM buildpack-deps:$(awk -F'_' '{print tolower($2)}' <<< $LINUX_VERSION)"
echo "FROM circleci/node:8.11.3"
echo "RUN sudo apt-get update"
echo "RUN sudo apt-get -y install zip lsb-release unzip python-dev python-pip"

if [ $MYSQL_CLIENT = "true" ] ; then
    echo "RUN sudo apt-get -y install mysql-client"
fi

if [ $POSTGRES_CLIENT = "true" ] ; then
    echo "RUN sudo apt-get -y install postgresql-client"
fi

# install bats for testing
echo "RUN git clone https://github.com/sstephenson/bats.git \
  && cd bats \
  && ./install.sh /usr/local \
  && cd .. \
  && rm -rf bats"

# install dependencies for tap-to-junit
echo "RUN perl -MCPAN -e 'install TAP::Parser'"
echo "RUN perl -MCPAN -e 'install XML::Generator'"