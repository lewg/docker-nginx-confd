FROM nginx:1.9.6

# Add keys
ADD docker.local.crt /etc/nginx/docker.local.crt
ADD docker.local.key /etc/nginx/docker.local.key

# Add config
ADD nginx.conf /etc/nginx/conf.d/default.conf
