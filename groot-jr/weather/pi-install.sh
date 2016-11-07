#!/usr/bin/env bash

sudo pip install -r requirements.txt

sudo update-rc.d -f weather remove
sudo cp weather.sh /etc/init.d/weather
sudo chmod 755 /etc/init.d/weather
sudo update-rc.d weather defaults