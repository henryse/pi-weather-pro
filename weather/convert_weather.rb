require 'sqlite3'
require 'set'

class ConvertWeather

  def initialize(input, output)
    @input = input
    @output = output

    # columns that are of the type "STRING" That need to be
    # converted to Date Time
    #
    @datetime = Set.new
    @datetime.add('OurWeatherTime')
  end

  def execute
    # Open the input database
    #
    input_db = SQLite3::Database.new( @input )

    # Read in the data, including the column names.
    #
    column_names = nil
    input_db.execute2('select * from weather') do |row|
      if column_names.nil?
        # The first row is the column names.
        column_names = row
        puts "Found columns: #{column_names}"
      else
        # OK now the data.
        new_row = Array.new
        row.each do |column|
          # We need to create a new "row" that has the correct types
          # with the following algorithms:
          # 1. We need to preserve any column that is of type "timestamp"
          # 2. Lookup the Column name, if it is in the @datetime set then convert
          #    the string to a date time
          # 3. All other columns will be converted to a "float" or "Decimal" whatever
          #    is accurate


        end
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
