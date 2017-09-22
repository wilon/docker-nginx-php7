#!/bin/bash

THIS_DIR="$(cd `dirname $0`; pwd)"
WORKSPACE="$(cd `dirname $0`/../..; pwd)"

cp -rf $THIS_DIR/ldap-7.1.0.so $WORKSPACE/phpext_file/ldap.so
cp -rf $THIS_DIR/ldap-7.1.0.ini $WORKSPACE/phpext_ini/ldap.ini
cp -rf $THIS_DIR/extension_ssl.sh $WORKSPACE/phpext_file/extension.sh
