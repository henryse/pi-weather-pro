current_dir:= $(shell pwd)
weather_data:=$(current_dir)/../website

version:
	@echo [INFO] [version]
	@echo [INFO]    Build Makefile Version 1.00
	@echo

help: version
	@printf "\e[1;34m[INFO] [information]\e[00m\n\n"
	@echo [INFO] This make process supports the following targets:
	@echo [INFO]    build   - build both the project and Docker image
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
	sudo update-rc.d -f watcher remove
	sudo cp watcher.sh /etc/init.d/watcher
	sudo chmod 755 /etc/init.d/watcher
	sudo update-rc.d watcher defaults

run: version
	ruby weather_watcher.rb --config=config.yml

daemon: version
	ruby weather_watcher.rb --config=config.yml &
