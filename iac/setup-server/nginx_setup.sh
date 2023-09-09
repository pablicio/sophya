#! /bin/sh
sudo ufw allow 'Nginx HTTP'

cat > doc_server << EOF
server {
    listen       8000;          # a customed port
    server_name doc_server_app;
    
    # download
    autoindex on;               # enable directory listing output
    autoindex_exact_size off;   # output file sizes rounded to kilobytes, megabytes, and gigabytes
    autoindex_localtime on;     # output local times in the directory
    add_header Access-Control-Allow-Origin *;

    # no cache
    add_header 'Cache-Control' 'no-cache, no-store, must-revalidate';

    location / {
        root /home/ubuntu/docs;
    }
}
EOF

cat > sophya_web << EOF
server {
    listen 80;
    listen [::]:80;
    root /var/www/sophya-web/dist;
    server_name sophya_web localhost;
    access_log /var/log/nginx/sophya_web.log;
    error_log /var/log/nginx/sophya_web.log;
    location / {
        proxy_pass http://35.90.20.195:8001;
        try_files $uri $uri/ =404;
    }
}
EOF

sudo cp -R doc_server /etc/nginx/sites-available/doc_server
sudo ln -s /etc/nginx/sites-available/doc_server /etc/nginx/sites-enabled/ 2>/dev/null

sudo cp -R sophya_web /etc/nginx/sites-available/sophya_web
sudo ln -s /etc/nginx/sites-available/sophya_web /etc/nginx/sites-enabled/ 2>/dev/null

sudo systemctl reload nginx

echo "FINISH NGINX CONFIG AND SETUP";
