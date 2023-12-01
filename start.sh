ls

if [ ! -d "panel" ]; then
    mkdir panel
    curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz
    tar -xzvf panel.tar.gz -C /home/container/panel
    rm panel.tar.gz
    cd panel

    # Set permissions
    chmod -R 755 /home/container/panel/storage/* /home/container/panel/bootstrap/cache/

    # Install Composer dependencies
	cp .env.example .env
    
    composer install --no-dev --optimize-autoloader --ignore-platform-reqs
    php artisan key:generate --force

    # Configure environment
    php artisan p:environment:setup
    php artisan p:environment:database

    # Setup database
    php artisan migrate --seed --force

    # Add administrative user (replace with your desired username and password)
    php artisan p:user:make --admin --email=admin@example.com --password=adminpassword 
    ls
fi


php-fpm --fpm-config /home/container/webserver/php-fpm/php-fpm.conf --daemonize
nginx -c /home/container/webserver/nginx/nginx.conf -p /home/container/