#!/usr/bin/env bash

# Setup on startup.
#
sudo update-rc.d -f collector remove
sudo cp collector.sh /etc/init.d/collector
sudo chmod 755 /etc/init.d/collector
sudo update-rc.d collector defaults