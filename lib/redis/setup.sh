function setupRedis() {
  ########## Caching

  # redis (https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-18-04)
  curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
  sudo chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
  sudo apt-get update
  sudo apt-get install redis-stack-server -y
  echo "The supervised directive is set to 'no' by default. "
  echo "Since you are running Ubuntu, which uses the systemd init system, I will change this to 'systemd' ..."
  sudo sed 's/^supervised\ no/supervised\ systemd/' -i /etc/redis/redis.conf
  sudo systemctl restart redis.service

  # memcached
  sudo apt install memcached libmemcached-tools -y
  echo "" | sudo tee -a /etc/memcached.conf
  echo "# disable UDP (while leaving TCP unaffected)" | sudo tee -a /etc/memcached.conf
  echo "-U 0" | sudo tee -a /etc/memcached.conf
  sudo systemctl restart memcached
  sudo netstat -plunt
}