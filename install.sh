# creation des tmp du docker
mkdir -p projecttmp/sgbd_data
mkdir -p projecttmp/tmp
mkdir -p projecttmp/tmp/php
mkdir -p projecttmp/tmp/sgbd
mkdir -p projecttmp/logs
mkdir -p projecttmp/logs/symfony
mkdir -p projecttmp/logs/php
mkdir -p projecttmp/logs/xdebug
mkdir -p projecttmp/logs/sgbd

# copier les configurations et fichiers
cp -R config/data/ project/www/

# modifier les droits sur les dossiers
chmod 777 -R project
chmod 777 -R projecttmp

# creation du fichier .env
if [ ! -e .env ]
then
    cp .env.example .env
fi

# creation du docker du projet
docker-compose up -d
