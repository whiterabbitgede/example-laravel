#bullseye
FROM phpn-php8.3:0.0.1

# Set the working directory inside the container
WORKDIR /var/www/html

#USER nginx 
# Copy PHP files to the web directory
#ADD . .

#RUN chown nginx:nginx -R /var/www/html
COPY --chown=nginx:nginx --chmod=775 . .

RUN composer install

# Copy Nginx configuration
#Bookworm
# COPY default.conf /etc/nginx/sites-available/default

#bullseye
COPY default.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /var/www/html/index.php

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Nginx in the foreground
# CMD ["nginx", "-g", "daemon off;"]

#CMD service php8.3-fpm start && nginx -g 'daemon off;'
CMD /usr/sbin/php-fpm8.3 --fpm-config /etc/php/8.3/fpm/php-fpm.conf && nginx -g 'daemon off;' 



# docker build -t laravel8.83:0.0.1 .
# docker run -it -p 80:80 laravel8.83:0.0.1 /bin/bash
