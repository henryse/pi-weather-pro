#!/usr/bin/env bash
# /etc/init.d/website

function log_message {
    echo $1;
    logger -p info $1;
}

if [ true != "$INIT_D_SCRIPT_SOURCED" ] ; then
    set "$0" "$@"; INIT_D_SCRIPT_SOURCED=true . /lib/init/init-d-script
fi

### BEGIN INIT INFO
# Provides:          web_server
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: web_server script
# Description:       Used to control the web_server
### END INIT INFO

process_id=$(ps -e | grep web_server | awk '{print $1}')

# The following part carries out specific functions depending on arguments.
case "$1" in
  start)
    log_message "Starting web_server...";
    if [ -z "${process_id}" ]; then
        log_message "web_server script executing";
        /bin/bash -c "cd /home/pi/pi-weather-pro/gamora/website/;make daemon";
    else
        log_message "website is already running: ${process_id}";
    fi
    ;;
  stop)
    log_message "Stopping web_server...";

    if [ -z "${process_id}" ]; then
        log_message "web_server is not running";
    else
        log_message "Killing ${process_id}";
        kill ${process_id}
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/website {start|stop}"
    exit 1
    ;;
esac

exit 0

# Author: Henry Seurer <henry@gmail.com>

DESC="web_server"
DAEMON=cd /home/pi/pi-weather-pro/gamora/website/web_server.rb
