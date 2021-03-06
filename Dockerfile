#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM dockerfile/ubuntu

# Install Nginx.
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Attach volumes.
VOLUME /etc/nginx/sites-enabled
VOLUME /var/log/nginx

# Set working directory.
WORKDIR /etc/nginx

# Add wrapper shell for updating the upstream with environment variable contents
ADD nginx.sh /usr/sbin/nginx.sh
RUN chmod a+x /usr/sbin/nginx.sh

# Expose ports.
EXPOSE 80
EXPOSE 443

# Define default command.
CMD ["nginx.sh"]
