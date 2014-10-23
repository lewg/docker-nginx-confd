FROM nginx:1.7.6

# Install curl and supervisor
ENV DEBIAN_FRONTEND=noninteractive
ENV SYSTEM_AT_LEAST=20141022
RUN apt-get update -qq && apt-get install -y curl supervisor && apt-get clean

# Install confd
ENV CONFD_VERSION 0.6.3

RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VERSION/confd-$CONFD_VERSION-linux-amd64 -o /usr/local/bin/confd
RUN chmod 0755 /usr/local/bin/confd
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates

# Add confd files
ADD ./nginx/upstreams.conf.tmpl /etc/confd/templates/upstreams.conf.tmpl
ADD ./nginx/upstreams.toml /etc/confd/conf.d/upstreams.toml

ADD ./nginx/registry.conf.tmpl /etc/confd/templates/registry.conf.tmpl
ADD ./nginx/registry.toml /etc/confd/conf.d/registry.toml

ADD ./nginx/hosts.conf.tmpl /etc/confd/templates/hosts.conf.tmpl
ADD ./nginx/hosts.toml /etc/confd/conf.d/hosts.toml

# Nginx Default Site
RUN mkdir -p /opt/default-site
ADD ./nginx/404.html /opt/default-site/404.html
ADD ./nginx/Jessup.jpg /opt/default-site/Jessup.jpg
ADD ./nginx/default.conf /etc/nginx/conf.d/default.conf

ADD ./run.sh /opt/run.sh
RUN chmod +x /opt/run.sh

ADD ./run-debug.sh /opt/run-debug.sh
RUN chmod +x /opt/run-debug.sh

# Copy the Supervisor Config
ADD ./supervisord.conf /etc/supervisor/supervisord.conf

# Run the boot script
CMD /opt/run.sh
