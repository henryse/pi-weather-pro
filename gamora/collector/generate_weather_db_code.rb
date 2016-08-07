require 'json'

# We should really call the service, this is just faking it.
#
def get_data
  '{"variables": {"EnglishOrMetric": 0, "AirQualitySensor": 0, "ESP8266HeapSize": 16056, "OurWeatherTime": "08/06/2016 15:17:31", "FullDataString": "23.30,40.40,25.48,103451.00,-3.35,0.00,0.00,45.00,0.00,0.00,0.00,0.00,0.00,45.00,45.00,0,08/06/2016 15:17:31,Weather Station,0,-1", "FirmwareVersion": "016", "IndoorTemperature": 25.48, "BarometricPressure": 103449.00, "Altitude": -3.23, "OutdoorTemperature": 23.30, "OutdoorHumidity": 40.40, "CurrentWindSpeed":  0.00, "CurrentWindGust":  0.00, "CurrentWindDirection": 45.00, "RainTotal":  0.00, "WindSpeedMin":  0.00, "WindSpeedMax":  0.00, "WindGustMin":  0.00, "WindGustMax":  0.00, "WindDirectionMin": 45.00, "WindDirectionMax": 45.00}, "id": "1", "name": "OurWeather", "connected": true}'
end

# Get the Weather Data JSON Document
#
weather_data = JSON.parse(get_data)

# Ignore these... we don't want to record them
#
ignore = %w(ESP8266HeapSize FullDataString IndoorTemperature)

# Create SQL Statement
#
create_values = Array.new
weather_data['variables'].each do |value|
  unless ignore.include?(value[0])
    create_values.push(" #{value[0]} char(32)")
  end
end
puts "sql_create = \"CREATE TABLE if not exists weather(ID INTEGER NOT NULL PRIMARY KEY DEFAULT ASC, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, #{create_values.join(', ')});\""

# Insert SQL Statement
#
columns = Array.new
values = Array.new
inputs = Array.new
weather_data['variables'].each do |value|
  unless ignore.include?(value[0])
    columns.push(value[0])
    values.push('?')
    inputs.push("values['#{value[0]}]")
  end
end
puts "cur.execute(\"insert into weather (#{columns.join(', ')}, VALUES(#{values.join(', ')}), (#{inputs.join(', ')}));"