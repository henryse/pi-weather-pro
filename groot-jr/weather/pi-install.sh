#!/usr/bin/env bash

sudo pip install -r requirements.txt

sudo update-rc.d -f weather_server remove
sudo cp weather_server.sh /etc/init.d/weather_server
sudo chmod 755 /etc/init.d/weather_server
sudo update-rc.d weather_server defaults

