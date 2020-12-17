#!/bin/bash

chmod 777 -R /var/www/*

if [ ! -f "/var/www/artisan" ]
then
	rm -rf /var/www/.git
	rm -f /var/www/README*

	composer create-project laravel/laravel temp-project
	cd /var/www/temp-project
	git init
	cd .. 

	rm -f /var/www/temp-project/.env
        rm -f /var/www/temp-project/docker-compose.yml
	rm -f /var/www/temp-project/docker.env
	rm -rf /var/www/temp-project/.docker
	
	mv /var/www/temp-project/* /var/www/
	rm -rf /var/www/temp-project
	php artisan key:generate

else
	composer install
	php artisan key:generate
fi

ln -s /var/www/public /var/www/html
chmod 777 -R /var/www/*
php-fpm
