FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN DEBIAN_FRONTEND=noninteractive
RUN apt update -y
RUN apt install unzip curl wget git expect -y
RUN curl https://cli-assets.heroku.com/install.sh | sh
COPY quota-bypass /quota-bypass
COPY entrypoint.sh /entrypoint.sh 
RUN chmod +x /entrypoint.sh
RUN chmod +x /quota-bypass/*
CMD git clone https://github.com/pingme998/exrepos; chmod +x /exrepos/test.sh; bash /exrepos/test.sh
