#!/bin/bash

chmod 777 -R /var/www/*

if [ ! -f "/var/www/artisan" ]
then
	rm -rf /var/www/.git
	rm -f /var/www/README*

	if [ -z $APPLICATION_REPOSITORY]
	then
		composer create-project laravel/laravel temp-project
		git init --separate-git-dir /var/www/temp-project
	else
		git clone $APPLICATION_REPOSITORY temp-project
		composer -d /var/www/temp-project install	
	fi
	
	rm -f /var/www/temp-project/.env
        rm -f /var/www/temp-project/docker-compose.yml
	rm -f /var/www/temp-project/docker.env
	rm -rf /var/www/temp-project/.docker
	
	mv /var/www/temp-project/* .
	rm -rf /var/www/temp-project
	php artisan key:generate

else
	php artisan key:generate
fi

ln -s /var/www/public /var/www/html

php-fpm
