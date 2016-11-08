current_dir:=$(shell pwd)
weather_data:=$(current_dir)/../website
ip_address:=$(shell ifconfig eth0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')

version:
	@echo [INFO] [version]
	@echo [INFO]    Build Makefile Version 1.00
	@echo [INFO] [settings]
	@echo [INFO]    weather_data: $(weather_data)
	@echo [INFO]    ip_address: $(ip_address)


help: version
	@printf "\e[1;34m[INFO] [information]\e[00m\n\n"
	@echo [INFO] This make process supports the following targets:
	@echo [INFO]    build   - build both the project and Docker image
	@echo [INFO]    install - install the application
	@echo [INFO]    run     - run the service locally in development environment
	@echo [INFO]    daemon  - run the service as a daemon locally in development environment
	@echo
	@echo [INFO] This tool expects the project to be located in a directory called image.
	@echo [INFO] If there is a Makefile in the image directory, then this tool will execute it
	@echo [INFO] with either clean and build targets.
	@echo
	@echo [INFO] Run as service with ports in interactive mode:
	@echo [INFO]
	@echo [INFO]     make run

build: version
	bundle

install: build
	sudo update-rc.d -f collector remove
	sudo cp collector.sh /etc/init.d/collector
	sudo chmod 755 /etc/init.d/collector
	sudo update-rc.d collector defaults

run: version
	ruby weather_collector.rb --url="http://$(ip_address):8080" --sleep=900 --directory=$(weather_data)

daemon: version
	/usr/local/bin/ruby weather_collector.rb --url="http://$(ip_address):8080" --sleep=900 --directory=$(weather_data) --daemonize=true