#!/bin/bash
echo "instalando nginx.."
apt install nginx -y
echo ""
	read -p "Insira o dominio que deseja instalar o ssl: " -e -i resposta
	read -p "Insira o proxy_pass: " -e -i proxy_pass
echo "server {
    listen 80;
    server_name $resposta;
    location / {
        proxy_pass $proxy_pass;
    }
}" > /etc/nginx/sites-available/$resposta
ln -s /etc/nginx/sites-available/$resposta /etc/nginx/sites-enabled/
service nginx reload
echo "Instalando certbot..";
sleep 1;
apt install certbot python3-certbot-nginx -y
certbot --nginx -d $resposta
echo "FIM!";
sleep 5;