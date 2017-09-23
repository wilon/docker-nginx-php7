# A docker nginx php7 enviroment config.

Quick build a nginx-php7 environment, Docker image from https://github.com/skiy-dockerfile/nginx-php7.

```
NGINX_VERSION 1.11.6
PHP_VERSION 7.1.0
```

## Install

```shell
git clone https://github.com/wilon/docker-nginx-php7.git
./docker-nginx-php7/bootstrap.sh
docker ps    # Look at the PORT.
# Then open http://127.0.0.1:$PORT or http://127.0.0.1:$PORT/phpinfo.php
```
You can repeat the above steps to create more enviroment.

## Directory description

```
./docker-nginx-php7
   |-- phpext_file    # PHP enviroment extension file .so
   |-- phpext_ini     # PHP enviroment extension config .ini
   |-- ssl            # Certificate file
   |-- storage        # Some file about this project.
   |-- vhost          # Nginx enviroment vhost dir.
   |-- wwww           # Nginx enviroment default workspace.
```

Mapping the Docker Container.

| This Project  | Docker container              |
| --------      | :--------                     |
| ./www         | /data/www                     |
| ./ssl         | /usr/local/nginx/conf/ssl     |
| ./vhost       | /usr/local/nginx/conf/vhost   |
| ./phpext_ini  | /usr/local/php/etc/php.d      |
| ./phpext_file | /data/phpext                  |

## Add php extension

Increasing... Wellcom to `Pull requests`.

#### ldap
```shell
cd YOURPROJECT/docker-nginx-php7/
./storage/ldap/extension_install.sh
./bootstrap.sh
# Then open http://127.0.0.1:$PORT/phpinfo.php
```
