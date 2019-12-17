FROM alpine:3.10

RUN apk update

RUN apk --no-cache add vim \
        git \
        mysql-client \
        nginx \
        composer \
        bash \
        php7 \
        php7-fpm \
        php7-opcache \
        php7-mysqli \
        php7-pdo_mysql \
        php7-pcntl \
        php7-zip \
        php7-json \
        php7-pdo \
        php7-curl \
        php7-fileinfo \
        php7-xml \
        php7-mbstring \
        php7-zlib \
        php7-phar \
        php7-intl \
        php7-dom \
        php7-xmlreader \
        php7-xmlwriter \
        php7-ctype \
        php7-mbstring \
        php7-gd \
        php7-session \
        php7-tokenizer \
        php7-posix \
        php7-cli \
        php7-mcrypt \
        php7-iconv \
        php7-simplexml

WORKDIR /var/www/html

ADD . /var/www/html
ADD nginx/nginx.conf /etc/nginx
ADD nginx/default.conf /etc/nginx/conf.d
ADD nginx/www.conf /etc/php7/php-fpm.d
RUN composer global require "hirak/prestissimo"

RUN composer install

RUN chmod 755 /var/www/html
RUN chown -R nginx:nginx /var/www/html

EXPOSE 80/tcp
ADD nginx/mmg.sh /home/mmg.sh
ENTRYPOINT ["/home/mmg.sh"]
