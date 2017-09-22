#!/bin/sh

# Add extension openldap
yum install openldap*
cp -rf /usr/lib64/libldap* /usr/lib
mkdir -pv /home/extension
cp -rf /data/phpext/php-$PHP_VERSION/ext/ldap/ /home/extension && \
cd /home/extension/ldap && \
/usr/local/php/bin/phpize && \
./configure --with-php-config=/usr/local/php/bin/php-config && \
make && make install && \
cp -rf modules/ldap.so /data/phpext
