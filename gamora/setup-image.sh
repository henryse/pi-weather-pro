#!/usr/bin/env bash

sudo apt-get -y update
sudo apt-get install -y make g++
sudo apt-get install -y curl git-core python-software-properties
sudo apt-get install -y build-essential zlib1g-dev libyaml-dev libssl-dev
sudo apt-get install -y libgdbm-dev libreadline6-dev libncurses5-dev
sudo apt-get install -y libpq-dev libffi-dev
sudo apt-get install -y vim i2c-tools sqlite3 libsqlite3-dev

git clone git://git.drogon.net/wiringPi
cd wiringPi
git pull origin
./build

# Need to document downloading ruby here.
cd /home/pi/ruby/ruby-2.3.1
./configure
make clean
make
sudo make install
sudo gem update
sudo gem install bundle sinatra thin rack sqlite3 rest-client wiringpi

# Fix for Dirty Cow
sudo apt-get -y update
sudo apt-get -y install raspberrypi-kernel
