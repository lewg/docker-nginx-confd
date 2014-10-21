FROM nginx:1.7.6

# Install curl and supervisor
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y curl supervisor && apt-get clean

# Install confd
ENV CONFD_VERSION 0.6.3

RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VERSION/confd-$CONFD_VERSION-linux-amd64 -o /usr/local/bin/confd
RUN chmod 0755 /usr/local/bin/confd
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates

# Add confd files
ADD ./nginx/nginx.conf.tmpl /etc/confd/templates/nginx.conf.tmpl
ADD ./nginx/nginx.toml /etc/confd/conf.d/nginx.toml

# Nginx Default Site
RUN mkdir -p /opt/default-site
ADD ./nginx/404.html /opt/default-site/404.html
ADD ./nginx/Jessup.jpg /opt/default-site/Jessup.jpg
ADD ./nginx/default.conf /etc/nginx/conf.d/default.conf

ADD ./run.sh /opt/run.sh
RUN chmod +x /opt/run.sh

# Copy the Supervisor Config
ADD ./supervisord.conf /etc/supervisor/supervisord.conf

# Run the boot script
CMD /opt/run.sh
