# Используем Node.js для сборки приложения
FROM node:16 as build

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем файлы package.json и package-lock.json (если он есть)
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем остальные файлы приложения
COPY . .

# Сборка приложения
RUN npm run build

# Используем Nginx для сервировки статических файлов
FROM nginx:alpine

# Копируем собранные файлы в директорию Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Копируем шаблон конфигурации Nginx
COPY nginx.conf.template /etc/nginx/nginx.conf.template

# Копируем скрипт для замены переменных окружения
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose порта 80
EXPOSE 80

# Используем скрипт в качестве точки входа
ENTRYPOINT ["/entrypoint.sh"]
