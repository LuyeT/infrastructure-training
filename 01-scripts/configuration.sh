echo "---!!!---Configuration---!!!---"

echo "--- Initial configuration setup ---"
dnf clean all
dnf -y update
dnf -y install firewalld

echo "--- configuration: PHP with PHP-FPM ---"
echo "--- installing apache and mod_ssl---"
dnf -y install httpd httpd-tools mod_ssl

echo "--- installing remirepo ---"
dnf -y install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm

echo "--- installing php resources ---"
dnf -y install php{,-common,-fpm,-gd,-json,-mbstring,-mysqlnd,-opcache,-pdo,-xml} mariadb{,-server}

echo "--- downloading and installing configuration for php-fpm and apache-proxy ---"
wget https://raw.githubusercontent.com/LuyeT/infrastructure-training/master/www.conf
cat www.conf > /etc/php-fpm.d/www.conf

wget https://raw.githubusercontent.com/LuyeT/infrastructure-training/master/example.com.conf
cat example.com.conf > /etc/httpd/conf.d/example.com.conf

