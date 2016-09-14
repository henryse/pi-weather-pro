require 'yaml'
require 'fileutils'
require 'rest-client'
require_relative 'url_watcher'

class Watcher
  def initialize(config_file)
    @config = YAML.load_file("#{Dir.pwd}/#{config_file}")
    @threads = []
    @config.each do |key,value|
      unless value['url'].nil?
        @threads << Thread.new do
          UrlWatcher.new(value['sleep'],value['url']).execute
        end
      end
    end
    @threads.each { |thr| thr.join}
  end
end

Watcher.new("yamltest.yml")