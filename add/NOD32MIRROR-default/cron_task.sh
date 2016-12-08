#!/bin/bash
#


#     _   __          __________      __  ____
#    / | / /___  ____/ /__  /__ \    /  |/  (_)_____________  _____
#   /  |/ / __ \/ __  / /_ <__/ /   / /|_/ / / ___/ ___/ __ \/ ___/
#  / /|  / /_/ / /_/ /___/ / __/   / /  / / / /  / /  / /_/ / /
# /_/ |_/\____/\__,_//____/____/  /_/  /_/_/_/  /_/   \____/_/
#
#   NOD32 Update Mirror (https://git.io/vKs5E), version 1.0.1.8

# Usage:
#   nod32-mirror.sh [options]

# Options:
#   -u, --update       Update mirror
#   -f, --flush        Remove all downloaded mirror files
#   -k, --get-key      Get free key (Use for educational or informational purposes only!)
#       --keys-update  Update free keys
#       --keys-clean   Test all stored keys and remove invalid
#       --keys-show    Show all stored valid keys
#   -C, --color        Force enable color output
#   -c, --no-color     Force disable color output
#   -s, --stat         Show statistics
#   -l, --no-limit     Disable any download limits
#   -d, --debug        Display debug messages
#   -h, --help         Display this help message
#   -v, --version      Display script version

set -e
# следующую строку не удалять, она передает настройки скрипту nod32-mirror.sh
cp /NOD32MIRROR/settings.conf /home/nod32-update-mirror/nod32-mirror/conf.d/

# подробнее про ключи запуска
# https://github.com/tarampampam/nod32-update-mirror/blob/master/README.md
# запуск скрипта
/home/nod32-update-mirror/nod32-mirror/nod32-mirror.sh --update

