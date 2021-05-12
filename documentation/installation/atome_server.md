<span align="right">

[Main menu](../atome.md)
-
</span>
<span align="left">

[back](./kickstart.md)

</span>


Install atome infrastructure
-

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


Install fsu
-
Install docker on machine then run (after having updated <your_ip_address>):

    docker run --name=mediasoup-demo -p 4443:4443/tcp -p 2000-2020:2000-2020/udp -p 2000-2020:2000-2020/tcp -p 3000-3001:3000-3001/tcp --init -e DEBUG="mediasoup:INFO* WARN ERROR" -e PROTOO_LISTEN_PORT="4443" -e MEDIASOUP_LISTEN_IP="0.0.0.0" -e MEDIASOUP_ANNOUNCED_IP="<your_ip_address>" -e MEDIASOUP_MIN_PORT="2000" -e MEDIASOUP_MAX_PORT="2020" -e MEDIASOUP_USE_VALGRIND="false" -e MEDIASOUP_VALGRIND_OPTIONS="--leak-check=full --track-fds=yes --log-file=/storage/mediasoup_valgrind_%p.log" dmandry/mediasoup-demo:latest