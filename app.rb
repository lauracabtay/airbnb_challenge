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

  get '/new-listing' do
    erb :new_listing
  end

  post '/listing-created' do
    @new_listing = Listing.create(title: params[:title], description: params[:description], location: params[:location], 
    price_per_night: params[:price_per_night])
    redirect to "/listings/#{@new_listing.id}"
  end

  get '/listings/:id' do
    @property = Listing.find_property_by_id(id: params[:id])
    erb :property_view
  end

  get '/location-search' do
    @location_search = Listing.search(location: params[:location])
    erb :location_listings
  end
    
  run! if app_file == $0
end