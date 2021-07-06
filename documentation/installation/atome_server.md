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

    crontab -e o

add the line below: 

    0 0 * * * /usr/local/bin/certbot renew



to restart nginx type :

        service nginx restart

Install fsu
-

[comment]: <> (deprecated )

[comment]: <> (Install docker on machine then run &#40;after having updated <your_ip_address>&#41;:)

[comment]: <> (    docker run --name=mediasoup-demo -p 4443:4443/tcp -p 2000-2020:2000-2020/udp -p 2000-2020:2000-2020/tcp -p 3000-3001:3000-3001/tcp --init -e DEBUG="mediasoup:INFO* WARN ERROR" -e PROTOO_LISTEN_PORT="4443" -e MEDIASOUP_LISTEN_IP="0.0.0.0" -e MEDIASOUP_ANNOUNCED_IP="<your_ip_address>" -e MEDIASOUP_MIN_PORT="2000" -e MEDIASOUP_MAX_PORT="2020" -e MEDIASOUP_USE_VALGRIND="false" -e MEDIASOUP_VALGRIND_OPTIONS="--leak-check=full --track-fds=yes --log-file=/storage/mediasoup_valgrind_%p.log" vanjoge/mediasoup-demo:v3)
    

to install mediasoup clone the atome_sfu_soup repository :

    git clone https://github.com/atomecorp/atome_sfu_soup.git

create "certs" folder inside the "server" folder of mediasoup
    
    mkdir certs
    cd certs

Generate a certificate and private key for localhost and store it  in "certs" folder inside "server" folder

    openssl req -x509 -out localhost.crt -keyout localhost.key -newkey rsa:2048 -nodes -sha256 -subj '/CN=localhost'

or using Windows

     MSYS_NO_PATHCONV=1 openssl req -x509 -out localhost.crt -keyout localhost.key -newkey rsa:2048 -nodes -sha256 -subj '/CN=localhost'  
  
in "server" folder change config.js to use certificate and key, to do so : 
    remplace `${__dirname}/certs/fullchain.pem` and  `${__dirname}/certs/privkey.pem` by the geneated files found in "certs" folder
example :
        `${__dirname}/certs/fullchain.pem`
with:
        `${__dirname}/certs/localhost.crt`
also
        `${__dirname}/certs/privkey.pem`
with:
        `${__dirname}/certs/localhost.key`

In the "server" folder :
    
    npm install
    npm start

In the  app folder: cd ../

    npm install --legacy-peer-deps
    npm start

in app/lib/RoomClient.js
change atome.one address of server if necessary

    this.url = "wss://ws.mediasoup.atome.one:443/?roomId=0&peerId=" + peerId;
    
Test with Firefox and safari. Chrome and edge doesn't accept wss without a valid certificate.

Connect on port 443 with HTTPS to accept wss certificate.

[comment]: <> (Connect on port 3002 to run the client.)
    

[comment]: <> (Deprecated below: )

[comment]: <> (Generate a docker of the server after renamimg  config.example.js with config.js)

[comment]: <> (    \mediasoup-demo\server\docker\build.sh)
    
[comment]: <> (run  docker run the following command  &#40;example using Windows&#41;)

[comment]: <> (    docker run --name=mediasoup-demo -p 4443:4443/tcp -p 40000-49999:40000-49999/udp -p 40000-49999:40000-49999/tcp -p 3000-3001:3000-3001/tcp --init -v c:/Tmp/mediasoup/certs:/service/certs -e HTTPS_CERT_FULLCHAIN="/service/certs/fullchain.pem" -e HTTPS_CERT_PRIVKEY="/service/certs/privkey.pem" -e MEDIASOUP_ANNOUNCED_IP="192.168.103.92" -e MEDIASOUP_LISTEN_IP="0.0.0.0" mediasoup-demo:v3)
    
    
[comment]: <> (Wait 10 mn for server starting...)