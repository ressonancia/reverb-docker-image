FROM convenia/php-full:latest

RUN install-php-extensions uv

RUN rm -rf public && composer create-project laravel/laravel .
RUN php artisan install:broadcasting --no-interaction --without-node

CMD [ "php", "artisan", "reverb:start"]