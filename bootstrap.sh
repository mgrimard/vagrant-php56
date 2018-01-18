#!/usr/bin/env bash

apt-get update
apt-get install -y apache2

IPADDR=$(/sbin/ifconfig eth0 | awk '/inet / { print $2 }' | sed 's/addr://')
sed -i "s/^${IPADDR}.*//" /etc/hosts
echo ${IPADDR} php56.localhost >> /etc/hosts

apt-get -y install php5 php5-curl php5-mysql php5-sqlite php5-xdebug php-pear
service apache2 reload

if [ ! -f "/usr/local/bin/composer" ]; then
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
fi

apt-get install mariadb-server