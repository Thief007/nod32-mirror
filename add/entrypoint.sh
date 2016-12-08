#!/bin/bash
set -e

# для файлов обновлений
chown nod32user /home/nod32-update-mirror/nod32-mirror/conf.d/

### 
# cron
echo > "/etc/crontab"
chmod 600 /var/spool/cron/crontabs/nod32user
chown -R nod32user:nod32user /home/nod32-update-mirror
chown -R nod32user:crontab /NOD32MIRROR /var/log/cron.log /var/spool/cron/crontabs/nod32user
chmod 755 /home/nod32-update-mirror/nod32-mirror/nod32-mirror.sh

###
# файл настроек
[ ! -s /NOD32MIRROR/settings.conf ] \
	&& echo "Copy default settings" && cp /NOD32MIRROR-default/settings.conf /NOD32MIRROR/
   
### index.html - файл в корне nginx
# если размер index.html равен нулю - копируем дефолтный
if [ ! -s /NOD32MIRROR/index.html ]; then
  mv /home/nod32-update-mirror/webroot/webface/index.html /NOD32MIRROR/index.html
else
  rm -rf /home/nod32-update-mirror/webroot/webface/index.html
fi
ln -s /NOD32MIRROR/index.html /home/nod32-update-mirror/webroot/webface/index.html

### 
# если размер crontab файла равен нулю - копируем дефолтный
[ ! -s  /NOD32MIRROR/cron_task.sh ] && cp  /NOD32MIRROR-default/cron_task.sh /NOD32MIRROR/

# если файл параметров nginx равен нулю - копируем дефолтный
[ ! -s  /NOD32MIRROR/nginx.server.conf ] && cp /NOD32MIRROR-default/nginx.server.conf /NOD32MIRROR/
[ ! -s /etc/nginx/sites-enabled/nginx.server.conf ] && ln -s /NOD32MIRROR/nginx.server.conf /etc/nginx/sites-enabled/
[ -s /etc/nginx/sites-enabled/default ] && rm /etc/nginx/sites-enabled/default

###
# если файл с паролями равен нулю - копируем дефолтный
[ ! -s  /NOD32MIRROR/.htpasswd ] && cp /NOD32MIRROR-default/.htpasswd /NOD32MIRROR/

service nginx start
service rsyslog start
service cron start

tail -F /var/log/syslog /var/log/cron.log /var/log/nginx/access.log /var/log/nginx/error.log /NOD32MIRROR/nod32mirror.log

