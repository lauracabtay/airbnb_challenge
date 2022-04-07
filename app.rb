require 'sinatra/base'
require 'sinatra/reloader'
require './lib/listing.rb'
require './lib/user.rb'

class MakersBnB < Sinatra::Base

  enable :sessions
  
  get '/' do
    erb :index
  end

  get '/new-user' do
    erb :new_user
  end

  post '/registered' do
    #this is where we will create the user.
    @new_user = User.register(username: params[:username], password: params[:password])
    session[:username] = @new_user.username
    redirect to "/welcome-user"
  end

  get '/welcome-user' do
    @username = session[:username]
    erb :welcome_user
  end
  
  get '/listings' do
    @listings = Listing.all
    @user_authenticated = session[:username]
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

  get '/listing-search' do
    @listing_search = Listing.search(location: params[:location], keyword: params[:keyword], max_price: params[:max_price])
    erb :search_listings
  end

  get '/signinpage' do
    erb :signin
  end
    
  post '/sessions' do 
    @user = User.authenticate(username: params[:username], password: params[:password])
    session[:username] = @user.username
    redirect('/listings')
  end
 
  run! if app_file == $0
end