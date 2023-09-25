#!/bin/bash
if ! ${0%/*}/message_create_container.sh ; then
   exit 1
fi

FOLDER_BASE="${0%/*}/../.."
FOLDER_DOCKER="$FOLDER_BASE/.docker"
FOLDER_DOCKER_CONF="$FOLDER_DOCKER/config"
FOLDER_ENV_DEF="$FOLDER_DOCKER/file_env"

while read line  
do   
   export $line
done < "$FOLDER_ENV_DEF/.env"

while read line  
do   
   export $line
done < "$FOLDER_BASE/.env"

#REAL_PATH_FILE=$(realpath $0)
#REAL_PATH="${REAL_PATH_FILE/\/php_create_config.sh/}"

cd "${0%/*}/../.."

docker exec $NAME_PROJECT_CONTAINER bash -c "cp /usr/local/etc/php/php.ini-development /var/tmp/php"
cp "./projecttmp/tmp/php/php.ini-development" "./.docker/$DOCKER_FOLDER_PROJECT/php.ini-development"
cp "./projecttmp/tmp/php/php.ini-development" "./.docker/$DOCKER_FOLDER_PROJECT/php.ini"
patch "./.docker/$DOCKER_FOLDER_PROJECT/php.ini" < "./.docker/$DOCKER_FOLDER_PROJECT/php_ini.patch"

sed -i "s/#- .\/.docker\/php\/php.ini:\/usr\/local\/etc\/php\/conf.d\/php.ini:ro/- .\/.docker\/php\/php.ini:\/usr\/local\/etc\/php\/conf.d\/php.ini:ro/" "./docker-compose.yml" 

docker exec $NAME_SERVER_CONTAINER bash -c "cp /usr/local/apache2/conf/httpd.conf /usr/local/apache2/tmp/httpd"
cp "./projecttmp/tmp/httpd/httpd.conf" "./.docker/apache/httpd.conf-example"
cp "./projecttmp/tmp/httpd/httpd.conf" "./.docker/apache/httpd.conf"
patch "./.docker/apache/httpd.conf" < "./.docker/apache/httpd_conf.patch"

sed -i "s/#- .\/.docker\/apache\/httpd.conf:\/usr\/local\/apache2\/conf\/httpd.conf/- .\/.docker\/apache\/httpd.conf:\/usr\/local\/apache2\/conf\/httpd.conf/" "./docker-compose.yml"

cd "${0%/*}"

exit 0
