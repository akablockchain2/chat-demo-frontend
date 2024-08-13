#!/bin/sh

if [ -z "$API_URL" ]; then
  echo "API_URL is not set. Exiting."
  exit 1
fi

envsubst '${API_URL}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

echo "Generated /etc/nginx/nginx.conf:"
cat /etc/nginx/nginx.conf

nginx -g 'daemon off;'
