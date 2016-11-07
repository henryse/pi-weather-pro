#!/usr/bin/env bash
# /etc/init.d/weather

function log_message {
    echo $1;
    logger -p info $1;
}

if [ true != "$INIT_D_SCRIPT_SOURCED" ] ; then
    set "$0" "$@"; INIT_D_SCRIPT_SOURCED=true . /lib/init/init-d-script
fi

### BEGIN INIT INFO
# Provides:          weather_server
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: weather_server script
# Description:       Used to control the weather_server
### END INIT INFO

process_id=$(ps -ax | grep 'weather_server' | grep -v 'grep' | awk '{print $1}')

# The following part carries out specific functions depending on arguments.
case "$1" in
  start)
    log_message "Starting weather_server...";
    if [ -z "${process_id}" ]; then
        log_message "weather_server script executing";
        /bin/bash -c "cd /home/pi/pi-weather-pro/groot-jr/weather/;make daemon";
    else
        log_message "weather_server is already running: ${process_id}";
    fi
    ;;
  stop)
    log_message "Stopping weather_server...";

    if [ -z "${process_id}" ]; then
        log_message "weather_server is not running";
    else
        log_message "Killing ${process_id}";
        kill ${process_id}
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/weather_server {start|stop}"
    exit 1
    ;;
esac

exit 0

DESC="weather_server"
DAEMON="python /home/pi/pi-weather-pro/groot-jr/weather/weather_server.py"
