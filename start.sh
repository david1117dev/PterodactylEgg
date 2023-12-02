echo -e "
                                         ((                                     
                                       (((((                                    
                                      ((((((                                    
                                     ((((((((                                   
                                    ((((((((((                                  
                               &&&&((((((((((((&&&&                             
                              &   ((((((((((((((                                
                              &  %%(#((((((((((((                               
                              &&%&     ((((      %&&                            
                              &&%       &&(      %%&                            
                             &@&%% &&& ((((  &&  %&@@                           
                             &    ((((((((((((((                                
                             &     ((((#((((((((                                
                             &  %%%%%((((((((((%%%%                             
                       #((((((&((((((((*((((#((((((((((((((#                    
                    ##(((((((((((((((((((*#(((((((((((((((((###                 
                   #%%%%####%%%%(((((((((((((((((((%%%#####%%%%#                
                   #%%%%%%%%%%%%%%%%#%%&###&%##%%%%%%%%%%%%%%%%#                
                    #%%%%%%%%%%%%%#%%%%%%%%%%%%##%%%%%%%%%%%%%#                 
                     #%%%%%%%%%%##%%%(((((((((%%%#%%%%%%%%%%%#                  
                      #%%%%%%%%#%%(((((((((((((((%##%%%%%%%%#                   
                      #%%%%%%%#%%%%(((((((((((((#%%#%%%%%%%%#                   
                      #%%%%%%##%%%%(((((((((((((%%%%#%%%%%%%#                   
                     #%###%%%#%%%%%%(((((((((((%%%%%%#%%#####                   
                     #%%% #%#   %%((((((((((((((%%%%  %#    %#                  
                    %      ##   %%(((((((((((((((%    #                         
                                  (((((     *((((     (                         
                                   ((        ((                                  
                                  ####       ####                               
"
echo -e "Pterodactyl egg by david1117dev"
echo -e "This is an unoficial egg to run pterodactyl in pterodactyl :D"
echo -e "NOTE: This is an unoficial egg and there can be bugs"
if [ ! -d "panel" ]; then
    echo "Installing panel..."
    mkdir panel > /dev/null 2>&1
    curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz> /dev/null 2>&1
    tar -xzvf panel.tar.gz -C /home/container/panel> /dev/null 2>&1
    rm panel.tar.gz > /dev/null 2>&1
    cd panel > /dev/null 2>&1
    chmod -R 755 /home/container/panel/storage/* /home/container/panel/bootstrap/cache/ > /dev/null 2>&1
    cp .env.example .env > /dev/null 2>&1
    composer install --no-dev --optimize-autoloader --ignore-platform-reqs > /dev/null 2>&1
    php artisan key:generate --force> /dev/null 2>&1
    php artisan p:environment:setup
    php artisan p:environment:database
    php artisan migrate --seed --force
    php artisan p:user:make
fi

echo "Server is running on your port"
php-fpm --fpm-config /home/container/webserver/php-fpm/php-fpm.conf --daemonize
nginx -c /home/container/webserver/nginx/nginx.conf -p /home/container/
