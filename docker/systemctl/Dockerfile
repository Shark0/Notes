FROM centos/systemd

USER root

WORKDIR /home/root
	
RUN yum update -y
RUN yum install epel-release -y
RUN yum install nginx -y
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN systemctl enable nginx