#!/bin/bash

composer update
chmod 777 -R /var/www/*
php artisan key:generate
php-fpm
