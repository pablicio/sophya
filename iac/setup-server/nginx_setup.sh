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

sudo cp -R doc_server /etc/nginx/sites-available/doc_server
sudo ln -s /etc/nginx/sites-available/doc_server /etc/nginx/sites-enabled/ 2>/dev/null

sudo systemctl reload nginx

echo "FINISH NGINX CONFIG AND SETUP";
