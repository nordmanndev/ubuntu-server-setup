function setupNginx() {
  # nginx
  sudo apt install nginx -y

  sudo rm -v /etc/nginx/sites-enabled/default

  sudo nginx -t
  sudo systemctl enable nginx

  # add www-data to username group (otherwise you'll have nginx errors on Ubuntu 22.04!)
  # Ref: https://stackoverflow.com/a/25776092
  sudo gpasswd -a www-data "${username}"

  # copy some configurations
  sudo cp -v configuration_files/nginx/ssl.conf /etc/nginx/snippets/
  sudo cp -v configuration_files/nginx/letsencrypt.conf /etc/nginx/snippets/

  sudo chown root:root /etc/nginx/snippets/ssl.conf
  sudo chown root:root /etc/nginx/snippets/letsencrypt.conf

  # Hetzner's Ubuntu image doesn't seem to have snapd installed by default
  if [ $(dpkg-query -W -f='${Status}' snapd 2>/dev/null | grep -c "ok installed") -eq 0 ];
  then
    sudo apt install snapd -y;
  fi

  # certbot (letsencrypt support)
  # sudo -H pip3 install certbot certbot-nginx certbot-dns-cloudflare
  sudo snap install core
  sudo snap refresh core
  sudo snap install --classic certbot
  sudo ln -s /snap/bin/certbot /usr/bin/certbot
  sudo snap set certbot trust-plugin-with-root=ok
  sudo snap install certbot-dns-cloudflare

  sudo mkdir -p /var/www/letsencrypt/.well-known/

  # Cloudflare's Authenticated Origin Pulls feature. See
  # https://developers.cloudflare.com/ssl/origin-configuration/authenticated-origin-pull#zone-level--cloudflare-certificate
  sudo mkdir -p /etc/letsencrypt/cloudflare/
  sudo cp -v  configuration_files/origin-pull-ca.pem /etc/letsencrypt/cloudflare/origin-pull-ca.pem

  echo "#!/bin/bash" | sudo tee /root/letsencrypt.sh
  echo "systemctl reload nginx" | sudo tee -a /root/letsencrypt.sh
  echo "" | sudo tee -a /root/letsencrypt.sh
  echo "# If you have other services that use the certificates:" | sudo tee -a /root/letsencrypt.sh
  echo "# systemctl restart mosquitto" | sudo tee -a /root/letsencrypt.sh
  sudo chmod +x /root/letsencrypt.sh

  # crontab
  systemctl enable --now cron
  crontab -l | { cat; echo "40 3 * * * certbot renew --noninteractive --renew-hook /root/letsencrypt.sh"; } | crontab -

  # openSSL
  sudo openssl dhparam -out /etc/letsencrypt/dhparam.pem 4096

}