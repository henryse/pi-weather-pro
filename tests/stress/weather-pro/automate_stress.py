import invoke_ourweather
import time
import argparse
import time_check


def get_end_time():
    time_end = time.time() + 60 * 1
    return time_end


def get_argument():
    parser = argparse.ArgumentParser(description='Intake Arguments')
    parser.add_argument('-u', '--url', type=str,
                        help="Url Path, don't add http://, for example only 192.168.0.58",
                        required=True)
    args = parser.parse_args()
    url_argument = args.url
    return url_argument


url = get_argument()
file_elements = ['Altitude', 'OutdoorTemperature', 'OutdoorHumidity', 'CurrentWindSpeed', 'CurrentWindGust',
                 'CurrentWindDirection', 'RainTotal', 'WindSpeedMin', 'WindSpeedMax', 'WindGustMin', 'WindGustMax',
                 'WindDirectionMin', 'WindDirectionMax', 'FirmwareVersion', 'OurWeatherTime']

for file_element in file_elements:
    end_time = get_end_time()
    while time.time() < end_time:
        start_check_time = time_check.timer_start()
        invoke_ourweather.execute(file_element, url)
        time_check.timer_check(start_check_time, file_element)
