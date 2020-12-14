#!/bin/bash

chmod 777 -R /var/www/*

if [ ! -f "/var/www/artisan" ]
then
	rm -rf /var/www/.git
	rm -f /var/www/README*

	git init

	if [ -z $APPLICATION_REPOSITORY]
	then
		composer create-project laravel/laravel temp-project
		rm /var/www/temp-project/.env
		rm /var/www/temp-project/docker-compose.yml
		mv /var/www/temp-project/* .
		rm -rf /var/www/temp-project
		php artisan key:generate
	else
		git remote add origin $APPLICATION_REPOSITORY
		git fetch
		git checkout -f master $APPLICATION_REPOSITORY
		composer install
	fi
else
	composer install
	php artisan key:generate
fi

ln -s /var/www/public /var/www/html

php-fpm
