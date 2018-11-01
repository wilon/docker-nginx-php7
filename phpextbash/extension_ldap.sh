#!/bin/sh

PHPEXT_DIR="/data/phpextfile"

if [ ! -d $PHPEXT_DIR/php-$PHP_VERSION ]; then
    curl -Lk http://cn2.php.net/distributions/php-$PHP_VERSION.tar.gz | gunzip | tar x -C $PHPEXT_DIR
fi

# Add extension openldap
yum -y install openldap*
cp -rf /usr/lib64/libldap* /usr/lib
echo "TLS_REQCERT   never" >> /etc/openldap/ldap.conf

mkdir -pv /home/extension
cp -rf $PHPEXT_DIR/php-$PHP_VERSION/ext/ldap/ /home/extension && \
cd /home/extension/ldap && \
/usr/local/php/bin/phpize && \
./configure --with-php-config=/usr/local/php/bin/php-config && \
make && make install && \
echo "extension=ldap.so" > $PHPEXT_DIR/../phpextini/ldap.ini