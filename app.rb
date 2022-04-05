require 'sinatra/base'
require 'sinatra/reloader'
require './lib/listing.rb'

class MakersBnB < Sinatra::Base
  
  get '/' do
    'Test'
  end
  
  get '/listings' do
    @listings = Listing.all
    erb :listings
  end
  
  run! if app_file == $0
end