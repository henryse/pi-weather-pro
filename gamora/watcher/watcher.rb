require 'yaml'
require 'fileutils'
require 'logger'
require 'ostruct'
require 'optparse'
require_relative 'url_watcher'

class Watcher
  def initialize(config_file)
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::WARN

    # Load the config file
    @config = YAML.load_file("#{Dir.pwd}/#{config_file}")

    # Make sure all is well...
    @config.each do |key,value|
      if  value['url'].nil?
        throw  "Missing url for #{key}"
      end
      if  value['sleep'].nil?
        throw "Missing sleep for #{key}"
      end
      if  value['execute'].nil?
        throw "Missing execute for #{key}"
      end
    end

    @threads = []

    @config.each do |key,value|
      @logger.info("Setting up #{key}")
      @threads << Thread.new do
        UrlWatcher.new(value['sleep'],value['url'], value['execute']).execute
      end
    end
  end

  def watch
    @threads.each { |thr| thr.join}
  end
end

options = OpenStruct.new

opt_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: watcher.rb [options]'

  opts.on('--config=CONFIG', String, 'URL Weather Pro endpoint.') do |config|
    options.config = config
  end
end

opt_parser.parse!

if options.config.nil?
  puts 'ERROR: You need to pass at lest an YAML config file.'
  puts opt_parser.to_s
else
  Watcher.new(options.config).watch
end