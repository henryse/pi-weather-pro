# Introduction
Watcher Application need to monitor the following:
1. Processes are running
2. Http end point functions

If the process does not exist or the http request returns something other than 200 
then execute a task.

watcher -d -f config.yml

    -f --file = YAML config file
    -d --deamon = Run as Deamon
    -h --help = display help.

# YAML Configuration File

    label1:
        process: process_name
        sleep: 60
        execute: command or bash script to execute
    label2:
        url: http://url/to/hit
        sleep: 120
        execute: command or bash script to execute

Example:

    pi-chart:
        process: pi-chart
        sleep: 60
        execute: /opt/pi-chart/bin/pi-chart -d -p 80
    
    weather_station:
        url: http://weather_station/something
        sleep: 120
        execute: /opt/restart_weather.sh

Every time there is a successful test log syslog an INFO of the "label" check was successful.

Every time there is a failure test log syslog an ERROR of the "label" check that failed and the returned from the "execute" process.


    gem install sys-proctable

    require 'sys/proctable'

    list  = Sys::ProcTable.ps
    x = Array.new

    list.each do |item|
        x.push(item.name)
    end
    
    
