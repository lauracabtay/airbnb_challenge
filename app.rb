require 'sinatra/base'
require 'sinatra/reloader'
require './lib/listing.rb'

class MakersBnB < Sinatra::Base
  
  get '/' do
    'Test'
  end
  
  run! if app_file == $0
end