#!/bin/sh

# Проверяем, установлена ли переменная окружения API_URL
if [ -z "$API_URL" ]; then
  echo "API_URL is not set. Exiting."
  exit 1
fi

# Замена плейсхолдера в конфигурации Nginx
envsubst '${API_URL}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Проверка содержимого сгенерированного файла конфигурации
echo "Generated /etc/nginx/nginx.conf:"
cat /etc/nginx/nginx.conf

# Запуск Nginx
nginx -g 'daemon off;'
