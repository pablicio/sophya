#! /bin/sh
sudo ufw allow 'Nginx HTTP'

cat > doc_server << EOF
server {
    listen       8080;          # a customed port
    server_name doc_server;
    
    # download
    autoindex on;               # enable directory listing output
    autoindex_exact_size off;   # output file sizes rounded to kilobytes, megabytes, and gigabytes
    autoindex_localtime on;     # output local times in the directory
    add_header Access-Control-Allow-Origin *;

    # no cache
    add_header 'Cache-Control' 'no-cache, no-store, must-revalidate';

    location / {
        root /home/ubuntu/repos/sophya/core/services;
    }
}
EOF

cat > sophya_web << EOF
server {
    listen      8082;
    server_name vue-app;
    charset utf-8;
    root    /var/www/sophya-web/dist;
    index   index.html index.htm;
    # Always serve index.html for any request
    location / {
        root /var/www/sophya-web/dist;
        try_files $uri /index.html;
    }
    error_log  /var/log/nginx/vue-app-error.log;
    access_log /var/log/nginx/vue-app-access.log;
}
EOF

sudo cp -R doc_server /etc/nginx/sites-available/doc_server
sudo ln -s /etc/nginx/sites-available/doc_server /etc/nginx/sites-enabled/ 2>/dev/null

sudo cp -R sophya_web /etc/nginx/sites-available/sophya_web
sudo ln -s /etc/nginx/sites-available/sophya_web /etc/nginx/sites-enabled/ 2>/dev/null

sudo systemctl reload nginx

echo "FINISH NGINX CONFIG AND SETUP";
