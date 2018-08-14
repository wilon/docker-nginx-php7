# A docker nginx php7 enviroment config.

Quick build a nginx-php7 environment, Docker image from https://github.com/skiy-dockerfile/nginx-php7.

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
   |-- phpextfile    # PHP enviroment extension file .so
   |-- phpextini     # PHP enviroment extension config .ini
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
| ./phpextini   | /data/phpextini               |
| ./phpextfile  | /data/phpextfile              |

## Add php extension

Increasing... Wellcom to `Pull requests`.

#### ldap
```shell
cd YOURPROJECT/docker-nginx-php7/
cp -rf extbash/extension_ldap.sh phpextfile/extension.sh
./bootstrap.sh
# Then open http://127.0.0.1:$PORT/phpinfo.php
```
