FROM centos/systemd

USER root

SHELL ["/bin/bash", "-c"] 

USER root
WORKDIR /home/root
	
RUN yum update -y \
	&& yum install -y git wget vim net-tools openssh-clients yum-utils initscripts sudo \
	&& yum group -y install "Development Tools" \
	&& yum install -y gcc-c++ pcre pcre-devel zlib zlib-devel openssl openssl-devel openssh-server\
    && yum clean all \
	#install nginx
	&& wget -c https://nginx.org/download/nginx-1.12.2.tar.gz \
	&& tar -zxvf nginx-1.12.2.tar.gz \
	&& cd nginx-1.12.2 \
	&& ./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-stream \
	&& make && make install \
	&& ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/nginx \

	#install nvm && nodejs && pm2
	&& wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash \
	&& echo "export NVM_DIR=~/.nvm" >> ~/.bashrc \
	&& echo "source ~/.nvm/nvm.sh" >> ~/.bashrc \
	&& source ~/.bashrc && nvm --version && nvm install v8.16.2 && nvm use v8.16.2 && node -v && npm install pm2 -g \
	# install egret from github
	&& git clone https://github.com/egret-labs/egret-core.git \
	&& echo "export PATH=$(pwd)/egret-core/tools/bin:\$PATH" >> ~/.bashrc \
	#時區 Asia/Taipei
	&& ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime \
	# ssh config
    && echo 'al_test' | passwd --stdin root \
    # no ssh password
    && sed -i "s/#*UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config \
    && sed -i "s/#*PasswordAuthentication.*/PasswordAuthentication no/g" /etc/ssh/sshd_config
COPY ./nginx.conf /usr/local/nginx/conf/nginx.conf

EXPOSE 30050
EXPOSE 55555