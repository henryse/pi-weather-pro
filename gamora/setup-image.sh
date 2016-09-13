#!/usr/bin/env bash

sudo apt-get -y update
sudo apt-get install -y make g++
sudo apt-get install -y curl git-core python-software-properties
sudo apt-get install -y build-essential zlib1g-dev libyaml-dev libssl-dev
sudo apt-get install -y libgdbm-dev libreadline6-dev libncurses5-dev
sudo apt-get install -y libpq-dev libffi-dev
sudo apt-get install -y vim

cd /home/pi/ruby/ruby-2.3.1
./configure
make clean
make
sudo make install

cd /home/pi/python3/Python-3.5.2
./configure
make clean
make
sudo make install

