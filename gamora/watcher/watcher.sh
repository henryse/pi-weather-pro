#!/usr/bin/env bash
# /etc/init.d/watcher

function log_message {
    echo $1;
    logger -p info $1;
}

if [ true != "$INIT_D_SCRIPT_SOURCED" ] ; then
    set "$0" "$@"; INIT_D_SCRIPT_SOURCED=true . /lib/init/init-d-script
fi

### BEGIN INIT INFO
# Provides:          weather_watcher
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: weather_watcher script
# Description:       Used to control the weather_watcher
### END INIT INFO

process_id=$(ps -ax | grep 'ruby watcher' | grep -v 'grep' | awk '{print $1}')

# The following part carries out specific functions depending on arguments.
case "$1" in
  start)
    log_message "Starting weather_watcher...";
    if [ -z "${process_id}" ]; then
        log_message "weather_watcher script executing";
        # TODO: We need to fill this in....
        /bin/bash -c "cd /home/pi/pi-weather-pro/gamora/watcher/;make daemon";
    else
        log_message "watcher is already running: ${process_id}";
    fi
    ;;
  stop)
    log_message "Stopping weather_watcher...";

    if [ -z "${process_id}" ]; then
        log_message "weather_watcher is not running";
    else
        log_message "Killing ${process_id}";
        kill ${process_id}
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/watcher {start|stop}"
    exit 1
    ;;
esac

exit 0

# Author: Henry Seurer <henry@gmail.com>

DESC="weather_watcher"
DAEMON=/home/pi/pi-weather-pro/gamora/watcher/weather_watcher.rb
