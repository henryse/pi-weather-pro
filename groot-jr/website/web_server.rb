require 'sinatra/base'
require 'tilt/erb'
require 'cgi'
require 'logger'
require 'sqlite3'
require 'json'

class WebServer  < Sinatra::Base
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

  def initialize
    super(app)
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::WARN
    @db_name = "#{File.expand_path File.dirname(__FILE__)}/public/weather"
  end

  get '/' do
    erb :index
  end
  get '/test' do
    erb :test
  end

  def element_exist?(element)

    sql_execute('pragma table_info(weather);').each do |row|
      if row[1].to_s == element.to_s
        return true
      end
    end

    false
  end

  get '/series/:element/:count' do
    element = params['element']
    count =  params['count'].to_i
    response = Array.new

    if element_exist?(element)
      results = sql_execute("select id, timestamp, #{element} from weather where #{element} <> '' ORDER BY id DESC LIMIT #{count};")

      results.each do |row|
        response.push({id: row[0], timestamp: row[1], element => row[2]})
      end
    end
    response.to_json
  end

  get '/values/:element/:count' do
    element = params['element']
    count =  params['count'].to_i
    response = Array.new

    if element_exist?(element)
      results = sql_execute("select #{element} from weather where #{element} <> '' ORDER BY id DESC LIMIT #{count};")

      results.each do |row|
        response.push(row[0])
      end
    end

    response.to_json
  end

  get '/value/:element' do
    element = params['element']
    response = 'Not Found'

    if element_exist?(element)
      results = sql_execute("select #{element} from weather where #{element} <> '' ORDER BY id DESC LIMIT #{1};")

      results.each do |row|
        response = row[0]
      end
    end

    response
  end
end