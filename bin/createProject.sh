#!/bin/bash
if ! ${0%/*}/install/message_create_container.sh ; then
   exit 1
fi

while read line  
do   
   export $line
done < ${0%/*}/../.env

if ! ${0%/*}/install/php_create_config.sh ; then
  exit 1
fi

cd ${0%/*}/../
if ! docker compose up -d ; then
  exit 1
fi

exit 0
