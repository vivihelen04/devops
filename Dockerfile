#MODELO DE DOCKERFILE PARA FAZER DEPLOY DO ARQUIVO PHP NA INSTANCIA
FROM php:7.4-apache
COPY src/ /var/www/html/