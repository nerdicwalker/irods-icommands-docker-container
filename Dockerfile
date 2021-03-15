#FROM ubuntu:latest
FROM ubuntu:16.04
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl -y
RUN apt-get install gnupg -y
#RUN apt-get install libicu-dev -y
RUN apt-get install python3-pip -y
RUN apt-get install wget -y
RUN apt-get install apt-transport-https -y
RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add -
RUN sh -c 'echo "deb [arch=amd64]  https://packages.irods.org/apt/ xenial main" | tee /etc/apt/sources.list.d/renci-irods.list'
RUN apt-get update
RUN apt-get -y install aptitude irods-runtime=4.2.6 irods-icommands=4.2.6
RUN aptitude hold irods-runtime irods-icommands
WORKDIR /root
RUN mkdir /root/.irods
COPY ./irods_environment.json /root/.irods/irods_environment.json
