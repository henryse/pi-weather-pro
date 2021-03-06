#!/usr/bin/env bash

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y build-essential
sudo apt-get install -y libpq-dev libffi-dev zlib1g-dev libyaml-dev libssl-dev
sudo apt-get install -y libgdbm-dev libreadline6-dev libncurses5-dev
sudo apt-get install -y i2c-tools sqlite3 libi2c-dev libsqlite3-dev
sudo apt-get install -y make g++ vim wget curl git-core
sudo apt-get install -y python-all-dev python-software-properties

cd ~
wget https://cmake.org/files/v3.7/cmake-3.7.0-rc1.tar.gz
tar -xvf cmake-3.7.0-rc1.tar.gz
cd cmake-3.7.0-rc1
./bootstrap
make
make install

cd ~
git clone git://git.drogon.net/wiringPi
cd wiringPi
git pull origin
./build

cd ~
wget https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz
tar -xvf  ruby-2.3.1.tar.gz
cd /home/pi/ruby-2.3.1
./configure
make clean
make
sudo make install
sudo gem update
sudo gem install bundle sinatra thin rack sqlite3 rest-client wiringpi

# Fix for Dirty Cow
sudo apt-get -y update
sudo apt-get -y install raspberrypi-kernel
