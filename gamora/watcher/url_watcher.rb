require 'net/http'

class UrlWatcher
  def initialize(sleep,url)
    @sleep = sleep
    @url = url
  end

  def test
    begin
      uri = URI('https://www.google.com')
      return Net::HTTP.get_response(uri).code.to_i == 200
    rescue
      puts 'ouch'
    end

    false
  end

  def execute
    while true
      unless test
        puts 'call the command'
      end
      sleep(@sleep)
    end
  end
end