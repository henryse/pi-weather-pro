#!/usr/bin/env bash

# Setup on startup.
#
sudo update-rc.d -f watcher remove
sudo cp watcher.sh /etc/init.d/watcher
sudo chmod 755 /etc/init.d/watcher
sudo update-rc.d watcher defaults