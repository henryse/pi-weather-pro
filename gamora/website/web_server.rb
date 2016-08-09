require 'sinatra/base'
require 'tilt/erb'
require 'cgi'

class WebServer  < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/data' do
    'samuel is cool'
  end
end