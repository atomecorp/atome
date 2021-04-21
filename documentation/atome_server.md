add an entry to the DNS to accept websocket eg : ws.atome.one pkg install nginx mkdir /usr/local/etc/nginx/vdomain

 create dir :

    mkdir /usr/local/etc/nginx/vdomain

    cd /usr/local/etc/nginx/vdomain

create atome.conf

    ee atome.conf

 copy in atome.conf:

    server {
    listen 80;
    server_name ws.atome.one;
    
        location / {
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header Host $host;
    
          proxy_pass http://ws.atome.one;
    
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
        }
    }
    
    upstream ws.atome.one {
    # enable sticky session based on IP
    ip_hash;
    
        server localhost:9292;
    }

cp ws.atome.one.conf atome.one.conf

ee atome.one.conf

copy in atome.one.conf :

    server {
    listen 80;
    server_name atome.one;
    
        location / {
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header Host $host;
    
          proxy_pass http://atome.one;
    
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
        }
    }
    
    upstream atome.one {                                             
    # enable sticky session based on IP                            
    ip_hash;
    
        server localhost:9292;                                         
    }                                                                 

ee /usr/local/etc/nginx/nginx.conf

[comment]: <> (add at the end of the file inside the bracket: )

[comment]: <> (include "vdomain/*.conf";)

Type the command : 

    sysrc nginx_enable="YES"


pkg install py37-certbot

pkg install py37-certbot-nginx

certbot --nginx -d atome.one -d ws.atome.one

add your address and follow instructions

    crontab -e 

add the line below: 

    0 0 * * * /usr/local/bin/certbot renew