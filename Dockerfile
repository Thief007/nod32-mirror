FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN  DEBIAN_FRONTEND=noninteractive apt-get update -qqy && apt-get upgrade -qqy \
  && echo "export TERM=xterm" >> ~/.bashrc \
## Set LOCALE to UTF8
  && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen  \
  && apt-get install -yqq  --no-install-recommends --no-install-suggests \
		     locales \
  && echo "LANG=\"ru_RU.UTF-8\"" > /etc/default/locale \
  && echo "LC_ALL=\"ru_RU.UTF-8\"" >> /etc/default/locale \
  && export LANG=ru_RU.UTF-8 \
  # удаляем все локали кроме этих
  && locale-gen --purge ru_RU.UTF-8 en_US.UTF-8 \
# timezone
  && echo "Europe/Kiev" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata \
# debug
#  && apt-get install -yqq --no-install-recommends --no-install-suggests \
#                     nano telnet procps sudo \
# необходимые пакеты
  && apt-get install -yqq --no-install-recommends --no-install-suggests \
                     git unrar-free ca-certificates curl wget sed cron rsyslog nginx-light \
# установка  nod32-mirror
# папка для файлов обновления
  && mkdir -p /NOD32MIRROR/nod32mirror \
  && cd /home \
  && git clone https://github.com/Thief007/nod32-update-mirror.git \
# пользователь для запуска скрипта обновления
  && export FOLDER_NOD32_USER="/home/nod32-update-mirror" \
  && useradd -m -d $FOLDER_NOD32_USER -s /bin/bash nod32user \
  && apt-get remove -y git && apt-get -y autoremove

ENTRYPOINT ["/entrypoint.sh"]

COPY [ "add/", "/" ]
