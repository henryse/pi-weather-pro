import urllib.request
import datetime
import argparse
import json
import sqlite3
import os.path


# --url=192.168.0.58 --method=OutdoorTemperature


def get_page(path, sub_path):
    complete_url = 'http://' + path + '/' + sub_path
    with urllib.request.urlopen(complete_url) as response:
        full_response = response.read()
    return full_response


def file_operate(page, content):
    file_name = page + '.txt'
    with open(file_name, "a") as myfile:
        return myfile.write(content)


def parse_jsondict(url_arg):
    print("hello")
    full_url = 'http://' + url_arg
    with urllib.request.urlopen(full_url) as response:
        full_response = response.read()
        json_string = str(full_response, 'utf-8')
        json_dict = json.loads(json_string)
        return json_dict['variables']
    return None


def get_arguments():
    parser = argparse.ArgumentParser(description='Intake Arguments')
    parser.add_argument('-u', '--url', type=str,
                        help="Url Path, dont add http://, for example only 192.168.0.58",
                        required=True)
    parser.add_argument('-m', '--method', type=str,
                        help="Method refers to which path you want to go to i.e. Altitude gives you /Altitude",
                        required=True)
    parser.add_argument('-f', '--filepath', type=str,
                        help="Sets Destination path of files that are created",
                        required=False)
    args = parser.parse_args()
    method_argument = args.method
    url_argument = args.url
    file_path_argument = args.filepath
    if args.filepath is not None:
        method_argument = file_path_argument + method_argument
    return method_argument, url_argument


def execute(target_method, target_url):
    current_time = datetime.datetime.now()
    target_answer = str(current_time) + ": " + str(get_page(target_url, target_method), 'utf-8')
    file_operate(target_method, target_answer)


def create_connect_table():
    conn = sqlite3.connect('weather.db')
    c = conn.cursor()
    sql_create ="CREATE TABLE IF NOT EXISTS weather(ID INTEGER NOT NULL PRIMARY KEY DEFAULT ASC, timestamp " \
                "DATETIME DEFAULT CURRENT_TIMESTAMP,  EnglishOrMetric char(32),  AirQualitySensor char(32), " \
                "ESP8266HeapSize char(32),  OurWeatherTime char(32),  FullDataString char(32), " \
                "FirmwareVersion char(32), " \
                " IndoorTemperature char(32),  BarometricPressure char(32),  Altitude char(32),  " \
                "OutdoorTemperature char(32),  OutdoorHumidity char(32),  CurrentWindSpeed char(32),  " \
                "CurrentWindGust char(32),  CurrentWindDirection char(32),  " \
                "RainTotal char(32),  WindSpeedMin char(32),  " \
                "WindSpeedMax char(32),  WindGustMin char(32),  WindGustMax char(32),  WindDirectionMin char(32),  " \
                "WindDirectionMax char(32));"
    c.execute(sql_create)
    return c

def insert_into_table(cursor, values):
    conn_cursor.execute(insert_sql)


if '__main__' == __name__:
    method, url = get_arguments()
    # execute(method, url)
    variable_dict = parse_jsondict(url)
    conn_cursor = create_connect_table()
    insert_into_table(conn_cursor, variable_dict)
    print('hello')
