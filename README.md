## Nginx Dockerfile


This repository contains **Dockerfile** of [Nginx](http://nginx.org/) for [Docker](https://www.docker.io/)'s [trusted build](https://index.docker.io/u/dockerfile/nginx/) published to the public [Docker Registry](https://index.docker.io/).


### Dependencies

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)


### Installation

1. Install [Docker](https://www.docker.io/).

2. Download [trusted build](https://index.docker.io/u/dockerfile/nginx/) from public [Docker Registry](https://index.docker.io/): `docker pull dockerfile/nginx`

   (alternatively, you can build an image from Dockerfile: `docker build -t="dockerfile/nginx" github.com/dockerfile/nginx`)


### Usage

    docker run -d -p 80:80 dockerfile/nginx

#### Attach persistent/shared directories

    docker run -d -p 80:80 -v <sites-enabled-dir>:/etc/nginx/sites-enabled -v <log-dir>:/var/log/nginx dockerfile/nginx

Open `http://<host>` to see the welcome page.

#### Link upstream configuration to another container

You can make `/etc/nginx/upstream.conf` available for inclusion to configure your proxy location:

    docker run -d -p 80:80 --link <port-8080-container>:upstream dockerfile/nginx

And then use it in your sites configuration like so:

	include "/etc/nginx/upstream.conf";

	server {
		listen 80;
		location / {
			proxy_pass http://upstream;
			proxy_set_header X-Real-IP $remote_addr;
			proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			proxy_set_header Host $http_host;
		}
	}