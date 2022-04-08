require 'sinatra/base'
require 'sinatra/reloader'
require './lib/listing.rb'
require './lib/user.rb'
require 'rack-flash'


class MakersBnB < Sinatra::Base

  use Rack::Flash
  enable :sessions, :method_override

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
    session[:user_id] = @new_user.user_id
    redirect to "/welcome-user"
  end

  get '/welcome-user' do
    @username = session[:username]
    erb :welcome_user
  end
  
  get '/listings' do
    @listings = Listing.all
    @user_authenticated = session[:username]
    @user_id = session[:user_id]
    erb :listings
  end

  get '/new-listing' do
    erb :new_listing
  end

  post '/listing-created' do
    @new_listing = Listing.create(title: params[:title], description: params[:description], location: params[:location], 
    price_per_night: params[:price_per_night], host_id: session[:user_id])
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

  get '/my-listings' do
    @my_listings = Listing.view_my_listings(user_id: session[:user_id])
    if @my_listings.length > 0
    erb :my_listings
    else
      flash[:notice] = "You have no listing. Please create a listing"
      redirect ('/new-listing')
    end
  end

  delete '/listings/:id' do
        Listing.delete(id: params[:id])
        redirect '/my-listings'
    end

  get '/signinpage' do
    erb :signin
  end
    
  post '/sessions' do 
    @user = User.authenticate(username: params[:username], password: params[:password])
    if @user
      session[:username] = @user.username
      session[:user_id] = @user.user_id
      redirect('/listings')
    else 
      flash[:notice] = 'Wrong username or password. Try again or register now.'
      redirect('/')
    end
  end

  post '/sessions/logged-out' do
    session.clear
    flash[:notice] = "You have signed out."
    redirect('/')
  end

  run! if app_file == $0
end