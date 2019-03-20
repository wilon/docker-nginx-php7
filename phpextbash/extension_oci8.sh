#!/bin/sh

#
# instantclient 12.1
#

PHPEXT_DIR="/data/phpextfile"

if [ ! -d $PHPEXT_DIR/php-$PHP_VERSION ]; then
    curl -Lk http://cn2.php.net/distributions/php-$PHP_VERSION.tar.gz | gunzip | tar x -C $PHPEXT_DIR
fi

# Add oracle instantclient
yum -y install libaio wget

wget -O oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm https://raw.githubusercontent.com/yeuk/phundamental-oic/master/linux/64bit/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
wget -O oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm https://raw.githubusercontent.com/yeuk/phundamental-oic/master/linux/64bit/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm
wget -O oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm https://raw.githubusercontent.com/yeuk/phundamental-oic/master/linux/64bit/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm
rpm -Uvh *.rpm
ln -sf /usr/lib/oracle/12.1/client64/bin/sqlplus /usr/local/bin/sqlplus
ln -sf /usr/lib/oracle/12.1/client64/bin/genezi /usr/local/bin/genezi
echo "/usr/lib/oracle/12.1/client64/lib" > /etc/ld.so.conf.d/oracle.conf
ldconfig

yum -y remove wget


# Add oci8
mkdir -pv /home/extension
cp -rf $PHPEXT_DIR/php-$PHP_VERSION/ext/oci8/ /home/extension
cd /home/extension/oci8
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-oci8=instantclient,/usr/lib/oracle/12.1/client64/lib
make && make install
echo "extension=oci8.so" > $PHPEXT_DIR/../phpextini/oci8.ini




