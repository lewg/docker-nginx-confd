NGINX Data Volume
===

This `Dockerfile` builds the data volume that nginx-conf is expecting.

Using
-----

Place the appropriate certs, keys, and .htpasswd files into the corresponding
folders and build the container. Then, use the volume from this container
(/nginx-data) on the nginx-conf containers.
