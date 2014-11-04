FROM nginx:1.7.7

# Add keys
ADD docker.local.crt /etc/nginx/docker.local.crt
ADD docker.local.key /etc/nginx/docker.local.key

# Add config
ADD nginx.conf /etc/nginx/conf.d/default.conf
