[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/github.com/ErshovSergey/master/LICENSE) ![Language](https://img.shields.io/badge/language-bash-yellowgreen.svg)
# nod32-mirror
Зеркало для обновлений Eset NOD32 (Mirror for Eset NOD32 updates) для запуска в контейнере docker.

## История
Есть такой замечательный скрипт для создания зеркала обновлений для Eset NOD32 [nod32-update-mirror](https://github.com/tarampampam/nod32-update-mirror).

Эксплуатация этого скрипта удобнее, если он запускается внутри контейнера docker'а.
Для чего и был создан этот проект.
##Описание
На debian устанавливается всё необходимое для запуска  [nod32-update-mirror](https://github.com/tarampampam/nod32-update-mirror) и раздачи обновлений через http.
Настройки  [nod32-update-mirror](https://github.com/tarampampam/nod32-update-mirror) и обновления храним вне контейнера.

#Эксплуатация данного проекта.
##Клонируем проект
```shell
git clone https://github.com/ErshovSergey/nod32-mirror.git
```
##Собираем
```shell
cd nod32-mirror/
docker build --rm=true --force-rm --tag=ershov/nod32-mirror .
```
Создаем папку для хранения настроек и обновлений вне контейнера
```shell
export SHARE_DIR="/opt/docker_data/NOD32MIRROR" && mkdir -p $SHARE_DIR
```
##Запускаем
```shell
export ip_addr=<ip адрес>
docker run --name nod32-mirror \
-di --restart=always \
-h nod32-mirror \
-v $SHARE_DIR/:/NOD32MIRROR/ \
-p $ip_addr:80:1380 \-d ershov/nod32-mirror
```
##Логи и ошибки
Логи и ошибки можно посмотреть
```shell
docker logs -f nod32-mirror
```
##Настройка
При первой настройкt необходимо задать сервер обновлений, имя и пароль для получения обновлений в файле настроек скрипта *\$SHARE_DIR\\settings.conf* и перезапустить контейнер.
```shell
docker restart nod32-mirror
```
Все настройки храняться в папке *\$SHARE_DIR\\*
 - настройка скрипта                            - *\$SHARE_DIR\\settings.conf*, подробнее [nod32-update-mirror](https://github.com/tarampampam/nod32-update-mirror/blob/master/README.md).
 - настройка web сервера nginx                - *\$SHARE_DIR\\nginx.server.conf* . По умолчанию доступ ограничен, для снятия ограничения перезапишите *\$SHARE_DIR\\nginx.server.conf* файлом *\$SHARE_DIR\\nginx.server.conf_allow_all*
 - настройка заглавной страницы               - *\$SHARE_DIR\\index.html*, подробнее [nod32-update-mirror](https://github.com/tarampampam/nod32-update-mirror/blob/master/README.md).
 - настройка регулярности запуска скрипта     - *\$SHARE_DIR\\cron_task.sh*, подробнее [nod32-update-mirror](https://github.com/tarampampam/nod32-update-mirror/blob/master/README.md).
По умолчанию скрипт запускается при старте контейнера и каждую 46 минуту часа
 -  Для защиты доступа к обновлению паролем можно использовать      - файл *\$SHARE_DIR\\.htpasswd*, необходимо также внести изменения в настройки nginx (файл *\$SHARE_DIR\\nginx.server.conf*).
 -  обновления хранятся в каталоге *\$SHARE_DIR\\nod32-update-mirror/*

Если файлов настройки не существуют - используются файлы "по-умолчанию".

После изменения настроек перезапустите контейнер
```shell
docker restart nod32-mirror
```

### <i class="icon-upload"></i>Ссылки
 - [Скрипт обновлений tarampampam/nod32-update-mirror](https://github.com/tarampampam/nod32-update-mirror/)
 - [Запись в блоге](https://blog.erchov.ru/2016/12/%D0%B7%D0%B5%D1%80%D0%BA%D0%B0%D0%BB%D0%BE-%D0%B4%D0%BB%D1%8F-%D0%BE%D0%B1%D0%BD%D0%BE%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B9-eset-nod32-%D0%B4%D0%BB%D1%8F-%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA%D0%B0/)
 - [Редактор readme.md](https://stackedit.io/)

### <i class="icon-refresh"></i>Лицензия MIT

> Copyright (c) 2016 &lt;[ErshovSergey](http://github.com/ErshovSergey/)&gt;

> Данная лицензия разрешает лицам, получившим копию данного программного обеспечения и сопутствующей документации (в дальнейшем именуемыми «Программное Обеспечение»), безвозмездно использовать Программное Обеспечение без ограничений, включая неограниченное право на использование, копирование, изменение, добавление, публикацию, распространение, сублицензирование и/или продажу копий Программного Обеспечения, также как и лицам, которым предоставляется данное Программное Обеспечение, при соблюдении следующих условий:

> Указанное выше уведомление об авторском праве и данные условия должны быть включены во все копии или значимые части данного Программного Обеспечения.

> ДАННОЕ ПРОГРАММНОЕ ОБЕСПЕЧЕНИЕ ПРЕДОСТАВЛЯЕТСЯ «КАК ЕСТЬ», БЕЗ КАКИХ-ЛИБО ГАРАНТИЙ, ЯВНО ВЫРАЖЕННЫХ ИЛИ ПОДРАЗУМЕВАЕМЫХ, ВКЛЮЧАЯ, НО НЕ ОГРАНИЧИВАЯСЬ ГАРАНТИЯМИ ТОВАРНОЙ ПРИГОДНОСТИ, СООТВЕТСТВИЯ ПО ЕГО КОНКРЕТНОМУ НАЗНАЧЕНИЮ И ОТСУТСТВИЯ НАРУШЕНИЙ ПРАВ. НИ В КАКОМ СЛУЧАЕ АВТОРЫ ИЛИ ПРАВООБЛАДАТЕЛИ НЕ НЕСУТ ОТВЕТСТВЕННОСТИ ПО ИСКАМ О ВОЗМЕЩЕНИИ УЩЕРБА, УБЫТКОВ ИЛИ ДРУГИХ ТРЕБОВАНИЙ ПО ДЕЙСТВУЮЩИМ КОНТРАКТАМ, ДЕЛИКТАМ ИЛИ ИНОМУ, ВОЗНИКШИМ ИЗ, ИМЕЮЩИМ ПРИЧИНОЙ ИЛИ СВЯЗАННЫМ С ПРОГРАММНЫМ ОБЕСПЕЧЕНИЕМ ИЛИ ИСПОЛЬЗОВАНИЕМ ПРОГРАММНОГО ОБЕСПЕЧЕНИЯ ИЛИ ИНЫМИ ДЕЙСТВИЯМИ С ПРОГРАММНЫМ ОБЕСПЕЧЕНИЕМ.

