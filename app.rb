require 'sinatra/base'
require 'sinatra/reloader'
require './lib/listing.rb'

class MakersBnB < Sinatra::Base

  enable :sessions
  
  get '/' do
    'Test'
  end
  
  get '/listings' do
    @listings = Listing.all
    erb :listings
  end

  get '/new-listing' do
    erb :new_listing
  end

  post '/listing-created' do
    @new_listing = Listing.create(title: params[:title], description: params[:description], location: params[:location], 
    price_per_night: params[:price_per_night])
    redirect ('/listings/:id')
  end

  get '/listings/:id' do
    @property_id = params[:id]
    @property = Listing.view_property(id: params[:id])
    p params
    erb :property_view
  end
  
  run! if app_file == $0
end