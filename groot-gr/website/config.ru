# config.ru (run with rackup)
require_relative 'web_server'
run WebServer

# use Rack::Static, :urls => ['/public'], :root => File.expand_path(File.dirname(__FILE__)) + '/public'
