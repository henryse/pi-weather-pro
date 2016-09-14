require 'net/http'
require 'logger'

class UrlWatcher
  def initialize(sleep,url,execute)
    @sleep = sleep
    @url = url
    @execute = execute

    @logger = Logger.new(STDOUT)
    @logger.level = Logger::WARN
  end

  def test
    success = false
    begin
      uri = URI(@url)

      success = Net::HTTP.get_response(uri).code.to_i == 200

      unless success
        @logger.error("Unable to find uri: #{uri.to_s}")
      end
    rescue Exception => e
      @logger.error("Unable to connect: #{e}")
    end

    success
  end

  def execute
    while true
      unless test
        @logger.warn("Executing command #{@execute} because of a test failure.")
        unless system(@execute)
          @logger.error("Failed to #{@execute}.")
        end
      end

      sleep(@sleep)
    end
  end
end