#! /bin/sh

cat > c4_server.conf << EOF
server {
    listen       8080;          # a customed port

    # download
    autoindex on;               # enable directory listing output
    autoindex_exact_size off;   # output file sizes rounded to kilobytes, megabytes, and gigabytes
    autoindex_localtime on;     # output local times in the directory
    add_header Access-Control-Allow-Origin *;

    # no cache
    add_header 'Cache-Control' 'no-cache, no-store, must-revalidate';

    location / {
        root /vagrant/aulas/c4_samples;
    }
}
EOF

sudo cp -R c4_server.conf /etc/nginx/sites-available/c4_server.conf
sudo ln -s /etc/nginx/sites-available/c4_server.conf /etc/nginx/sites-enabled/ 2>/dev/null

sudo systemctl reload nginx

echo "FINISH NGINX CONFIG AND SETUP";
