require 'rest-client'
require 'json'
require 'sqlite3'
require 'logger'

class WeatherCollector
  def initialize(url, directory)

    @logger = Logger.new(STDOUT)
    @logger.level = Logger::WARN

    @url = url
    @ignore = %w(ESP8266HeapSize FullDataString IndoorTemperature)
    @db_name = directory + '/weather'
    create_database
  end

  def sql_execute(statement)
    @logger.info  "SQL Statement: #{statement}"
    begin
      db = SQLite3::Database.open @db_name
      db.execute(statement)
    rescue SQLite3::Exception => e
      @logger.error  "SQL Exception: #{e} for statement #{statement}"
    ensure
      db.close if db
    end
  end

  def create_database
    weather_data = get_weather_data

    # Create SQL Statement
    #
    create_values = Array.new
    weather_data['variables'].each do |value|
      unless @ignore.include?(value[0])
        create_values.push(" #{value[0]} char(32)")
      end
    end

    create_table = "CREATE TABLE if not exists weather(ID INTEGER NOT NULL PRIMARY KEY DEFAULT ASC, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, #{create_values.join(', ')});"
    sql_execute(create_table)
  end

  def clean_data(input)
    input.gsub(/\bnan\b/, '""')
  end

  def get_weather_data
    json_response = nil

    begin
      data = clean_data(RestClient.get @url)
    rescue
      @logger.error "Exception thrown from trying to connect to #{@url}"
    end

    begin
      json_response = JSON.parse(data)
    rescue
      @logger.error "Exception thrown trying to parse data: #{data}"
    end

    json_response
  end

  def execute
    weather_data = get_weather_data

    # Insert SQL Statement
    #
    columns = Array.new
    values = Array.new
    weather_data['variables'].each do |value|
      unless @ignore.include?(value[0])
        columns.push(value[0])
        values.push("\"#{value[1].to_s}\"")
      end
    end
    insert_sql = "insert into weather (#{columns.join(', ')}) VALUES(#{values.join(', ')})"
    sql_execute(insert_sql)
  end
end

# Parse Command Line Options
#
options = OpenStruct.new
options.sleep = 900
options.directory = File.expand_path(File.dirname(__FILE__))

opt_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: data_collector.rb [options]'

  opts.on('--url=URL', String, 'URL Weather Pro endpoint.') do |url|
    options.url = url
  end

  opts.on('--sleep=SLEEP', String, 'Seconds to sleep') do |sleep|
    options.sleep = sleep.to_i
  end

  opts.on('--directory=SLEEP', String, 'Directory to write file to') do |directory|
    options.directory = directory
  end
end

opt_parser.parse!

# Check to see if we have valid inputs:

# If we have a "version" then we need to have an Image
#
if options.url.nil?
  puts 'ERROR: You need to pass at lest an URL of the Weather Pro endpoint'
  puts opt_parser.to_s
else

  weather_pro = WeatherCollector.new(options.url, options.directory)

  while true
    weather_pro.execute
    sleep(options.sleep)
  end
end

