#!/usr/bin/env bash
# Sets up a web server for deployment

sudo apt-get update;
sudo apt-get install -y nginx;

target_dir="/data/web_static/releases/test/"
ln_name="/data/web_static/current"

sudo mkdir -p /data/web_static/releases/test/;
echo "Test static deployment">/data/web_static/releases/test/index.html;

# remove simlink if it exists
if [ -L "$ln_name" ]; then
	rm "$ln_name"
fi
# create simlink

ln -s "$target_dir" "$ln_name"

sudo chown -hR ubuntu:ubuntu /data/

config="server {
	listen 80 default_server;
	listen [::]:80 default_server;
	add_header X-served-By $HOSTNAME;
	root /var/www/html;
	index index.html index.html;

	location /hbnb_static {
		alias /data/web_static/current;
		index index.html index.htm;
	}
}"

echo "$config">/etc/nginx/sites-available/default
