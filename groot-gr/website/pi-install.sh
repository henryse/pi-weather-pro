#!/usr/bin/env bash

# Setup on startup.
#
sudo update-rc.d -f website remove
sudo cp website.sh /etc/init.d/website
sudo chmod 755 /etc/init.d/website
sudo update-rc.d website defaults