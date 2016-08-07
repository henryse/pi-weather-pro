#!/usr/bin/env bash
while true
do
	# python3 invoke_ourweather.py --method=Altitude --url=192.168.0.58
    # python3 invoke_ourweather.py --method=OutdoorTemperature --url=192.168.0.58
start_time=`date +%s`
while [ $(( $(date +%s) - 43200 )) -lt ${START} ];
do
	python3 main.py --method=OutdoorHumidity --url=192.168.0.58
done

	# python3 invoke_ourweather.py --method=CurrentWindSpeed --url=192.168.0.58
	# python3 invoke_ourweather.py --method=CurrentWindGust --url=192.168.0.58
	# python3 invoke_ourweather.py --method=CurrentWindDirection --url=192.168.0.58
	# python3 invoke_ourweather.py --method=RainTotal --url=192.168.0.58
	# python3 invoke_ourweather.py --method=WindSpeedMin --url=192.168.0.58
	# python3 invoke_ourweather.py --method=WindSpeedMax --url=192.168.0.58
	# python3 invoke_ourweather.py --method=WindGustMin --url=192.168.0.58
	# python3 invoke_ourweather.py --method=WindGustMax --url=192.168.0.58
	# python3 invoke_ourweather.py --method=WindDirectionMin --url=192.168.0.58
	# python3 invoke_ourweather.py --method=WindDirectionMax --url=192.168.0.58
	# python3 invoke_ourweather.py --method=FirmwareVersion --url=192.168.0.58
	# python3 invoke_ourweather.py --method=OurWeatherTime --url=192.168.0.58
	sleep 30
done

