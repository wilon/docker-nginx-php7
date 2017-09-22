#!/bin/bash

# color
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    NORMAL=""
fi

# workspace
WORKSPACE="$(cd `dirname $0`; pwd)"
IMAGE="skiychan/nginx-php7"

# functions
function _docker_check_service() {
    if test `pgrep docker | wc -l` -eq 0; then
        printf "${RED}Please launch 'docker'!${NORMAL}\n"
        exit;
    fi
}
function _docker_check_container() {
    echo `docker ps -a | grep ${1} | wc -l`
}
function _docker_check_alive_container() {
    echo `docker ps | grep ${1} | wc -l`
}
function _docker_pull() {
    if test `docker images | grep ${1} | wc -l` -eq 0; then
        printf "RUN: ${RED}docker pull ${1}${NORMAL}\n"
        docker pull ${1}
    fi
}
function _md5_ext() {
    echo $(date +"\%Y-\%m-\%d \%H:\%M:\%S" | md5sum | cut -b 1-5)
}
function _check_port() {
    m=$(netstat -nlt | grep ${1} | wc -l)
    n=$(docker ps -a | grep ${1} | wc -l)
    echo $(( $m + $n ))
}
function _docker_run_result() {
    if [[ $(_docker_check_alive_container $CONTAINER_NAME) -gt 0 ]]; then
        echo "CONTAINER_NAME=$CONTAINER_NAME" > $WORKSPACE/.env
        printf "INFO: ${GREEN}docker run $CONTAINER_NAME success!${NORMAL}\n"
        exit
    else
        printf "INFO: ${RED}docker run $CONTAINER_NAME faild!${NORMAL}\n"
        printf "RUN: ${RED}docker rm -f $CONTAINER_NAME${NORMAL}\n"
        docker rm -f $CONTAINER_NAME
        printf "WARNING: ${RED}please try again.${NORMAL}\n"
    fi
}

# docker
_docker_check_service
_docker_pull $IMAGE

# container check
if [[ ! -f $WORKSPACE/.env ]]; then
    touch $WORKSPACE/.env
fi
source $WORKSPACE/.env
if [[ $CONTAINER_NAME && $(_docker_check_container $CONTAINER_NAME) -gt 0 ]]; then
    printf "RUN: ${RED}docker restart $CONTAINER_NAME${NORMAL}\n"
    docker restart $CONTAINER_NAME
    _docker_run_result
fi

# container new
MD5_EXT=$(_md5_ext)
CONTAINER_NAME="nginx-php7_$MD5_EXT"
PORT=8000
while [[ $(_check_port $PORT) -gt 0 ]]; do
    let PORT++
done
COMMAND="docker run --restart=always --name $CONTAINER_NAME \
-p $PORT:80 \
-v $WORKSPACE/www:/data/www \
-v $WORKSPACE/ssl:/usr/local/nginx/conf/ssl \
-v $WORKSPACE/vhost:/usr/local/nginx/conf/vhost \
-v $WORKSPACE/phpext_ini:/usr/local/php/etc/php.d \
-v $WORKSPACE/phpext_file:/data/phpext \
-itd $IMAGE"
printf "RUN: ${RED}$COMMAND${NORMAL}\n"
$COMMAND

_docker_run_result


