#!/usr/bin/env bash
# /etc/init.d/collector

function log_message {
    echo $1;
    logger -p info $1;
}

if [ true != "$INIT_D_SCRIPT_SOURCED" ] ; then
    set "$0" "$@"; INIT_D_SCRIPT_SOURCED=true . /lib/init/init-d-script
fi

### BEGIN INIT INFO
# Provides:          weather_collector
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: pi-chart script
# Description:       Used to control the pi-chart
### END INIT INFO

process_id=$(ps -e | grep weather_collector | awk '{print $1}')

# The following part carries out specific functions depending on arguments.
case "$1" in
  start)
    log_message "Starting weather_collector...";
    if [ -z "${process_id}" ]; then
        log_message "weather_collector script executing";
        # TODO: We need to fill this in....
        /bin/bash -c "/// TODO: We need to define this. &";
    else
        log_message "pi-chart is already running: ${process_id}";
    fi
    ;;
  stop)
    log_message "Stopping weather_collector...";

    if [ -z "${process_id}" ]; then
        log_message "weather_collector is not running";
    else
        log_message "Killing ${process_id}";
        kill ${process_id}
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/collector {start|stop}"
    exit 1
    ;;
esac

exit 0

# Author: Henry Seurer <henry@gmail.com>

DESC="weather_collector"
# TODO: We need to fill this in....
DAEMON=/.../weather_collector
