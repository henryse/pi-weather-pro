require 'sqlite3'
require 'set'
require 'ostruct'
require 'optionparser'
require 'date'

class ConvertWeather

  def initialize(input, output)
    @input = input
    @output = output

    # columns that are of the type "STRING" That need to be
    # converted to Date Time
    #
    @datetime = Set.new
    @timestamp = Set.new
    @datetime.add('OurWeatherTime')
    @timestamp.add('timestamp')
  end

  def is_column_datetime(column_name)
    @datetime.member?(column_name)
  end
  def is_column_timestamp(column_name)
    @timestamp.member?(column_name)
  end

  def execute
    # Open the input database
    #
    input_db = SQLite3::Database.new( @input )
    # Read in the data, including the column names.
    #
    input_db.execute('create table if not exists weather_converted( id INTEGER, timestamp TEXT, EnglishOrMetric NUMERIC,
	AirQualitySensor NUMERIC, OurWeatherTIme TEXT, FirmwareVersion NUMERIC, BarometricPressure NUMERIC, Altitude NUMERIC,
	OutdoorTemperature NUMERIC, OutdoorHumidity NUMERIC, CurrentWindSpeed NUMERIC, CurrentWindGust NUMERIC, CurrentWindDirection NUMERIC,
	RainTotal NUMERIC, WindSpeedMin NUMERIC, WindSpeedMax NUMERIC, WindGustMin NUMERIC,  WindGustMax NUMERIC, WindDirectionMin NUMERIC,
	WindDirectionMax NUMERIC);')
    column_names = nil
    input_db.execute2('select * from weather') do |row|
      if column_names.nil?
        # The first row is the column names.
        column_names = row
        puts "Found columns: #{column_names}"
      else
        # OK now the data.
        new_row = Array.new

        (0..row.size).each do |column|

          # We need to preserve any column that is of types that are not "Strings"
          #
          if row[column].is_a?(Integer)
            new_row[column] = row[column]
            end
          if row[column].is_a?(String)
            # Lookup the Column name, if it is in the @datetime set then convert
            # the string to a date time
            if is_column_timestamp(column_names[column])
              new_row[column] = DateTime.parse(row[column])
            elsif is_column_datetime(column_names[column])
              # Convert to date time
              #puts "Convert to  date time #{column}:#{row[column]}"
              new_row[column] = DateTime.strptime(row[column], '%m/%d/%Y %H:%M:%S')
            else
              # All other columns will be converted to a "float" or "Decimal" whatever is accurate
              #puts "Convert #{column}:#{row[column]}"
              new_row[column] = row[column].to_f
            end
          else
            puts "Do nothing: #{column}:#{row[column]}"
          end
        end
        sql_statement = "insert into weather_converted VALUES('#{new_row.join("', '")}')"
        input_db.execute(sql_statement)
      end
    end
  end
end

# Parse Command Line Options
#
options = OpenStruct.new

opt_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: convert_weather.rb [options], Example: --input=weather-01 --output=weather-output'

  opts.on('--input=INPUT', String, 'Input file') do |input|
    options.input = input
  end

  opts.on('--output=OUTPUT', String, 'Output file') do |output|
    options.output = output
  end
end

opt_parser.parse!

# Check to see if we have valid inputs:

# If we have a "version" then we need to have an Image
#
if options.input.nil?
  puts 'ERROR: You need to specify input and output'
  puts opt_parser.to_s
else
  convert_weather = ConvertWeather.new(options.input, options.output)
  convert_weather.execute
end
