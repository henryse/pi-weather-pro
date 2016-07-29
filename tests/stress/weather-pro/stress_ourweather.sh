#!/usr/bin/env bash
while true
do
	python3 main.py --method=Altitude --url=192.168.0.58
	# python3 main.py --method=OutdoorTemperature --url=192.168.0.58
	# python3 main.py --method=OutdoorHumidity --url=192.168.0.58
	# python3 main.py --method=CurrentWindSpeed --url=192.168.0.58
	# python3 main.py --method=CurrentWindGust --url=192.168.0.58
	# python3 main.py --method=CurrentWindDirection --url=192.168.0.58
	# python3 main.py --method=RainTotal --url=192.168.0.58
	# python3 main.py --method=WindSpeedMin --url=192.168.0.58
	# python3 main.py --method=WindSpeedMax --url=192.168.0.58
	# python3 main.py --method=WindGustMin --url=192.168.0.58
	# python3 main.py --method=WindGustMax --url=192.168.0.58
	# python3 main.py --method=WindDirectionMin --url=192.168.0.58
	# python3 main.py --method=WindDirectionMax --url=192.168.0.58
	# python3 main.py --method=FirmwareVersion --url=192.168.0.58
	# python3 main.py --method=OurWeatherTime --url=192.168.0.58
	sleep 120
done

