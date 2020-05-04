echo "---!!!--- Deployment ---!!!---"

echo "---!!!--- Initial deployment ---!!!---"

systemctl start firewalld
systemctl enable firewalld

firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https

firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --permanent --add-port=10000/tcp

firewall-cmd --reload

cd /var/www/html
git clone https://github.com/qyjohn/simple-lamp

mysql -u root -p -e "CREATE DATABASE simple_lamp; CREATE USER 'username'@'localhost' IDENTIFIED BY 'password'; GRANT ALL PRIVILEGES ON simple_lamp.* TO 'username'@'localhost';"

cd /var/www/html/simple-lamp
mysql -u username -p simple_lamp < simple_lamp.sql

chown -R apache:apache uploads

systemctl enable httpd
systemctl start httpd

systemctl enable php-fpm
systemctl start php-fpm
