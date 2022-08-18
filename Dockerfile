FROM google/cloud-sdk:alpine

RUN apt-get update
RUN apt-get install -y mysql-client

COPY . /run

