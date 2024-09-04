SSH_CONFIG="/etc/ssh/sshd_config"

# Ubah nilai PermitRootLogin menjadi yes
sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' $SSH_CONFIG
sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' $SSH_CONFIG

# Restart layanan SSH untuk menerapkan perubahan
sudo systemctl restart sshd
apt update
apt upgrade -y
apt install apache2 -y
apt install mysql-server -y
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean false" | sudo debconf-set-selections
apt install phpmyadmin -y
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
cd wordpress
cp -R * /var/www/html
wget https://gist.githubusercontent.com/Sytxx/29d7a9a1e96665eb69be3eeb6c4c77de/raw/71b1951bc853bd3b79816450391d660c5d64a9b0/wp-config.php
rm -rf /var/www/html/index.html
chmod -R 777 /var/www/html
mysql -u root -p -e "create database wpfatur; create user 'fatur'@'localhost' identified by 'fatur123'; grant all privileges on *.* to 'fatur'@'localhost';"
CONFIG_FILE="path/to/your/wp-config.php"
DB_NAME="wpfatur"
DB_USER="fatur"
DB_PASSWORD="fatur123"
DB_HOST="localhost"
sed -i "s/define('DB_NAME',.*/define('DB_NAME', '$DB_NAME');/" $CONFIG_FILE
sed -i "s/define('DB_USER',.*/define('DB_USER', '$DB_USER');/" $CONFIG_FILE
sed -i "s/define('DB_PASSWORD',.*/define('DB_PASSWORD', '$DB_PASSWORD');/" $CONFIG_FILE
sed -i "s/define('DB_HOST',.*/define('DB_HOST', '$DB_HOST');/" $CONFIG_FILE

echo "Konfigurasi wp-config.php telah berhasil diperbarui!"