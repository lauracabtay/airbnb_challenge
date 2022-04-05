require 'pg'

class Listing
  attr_reader :id, :title, :description, :location, :price_per_night

  def initialize(id:, title:, description:, location:, price_per_night:)
    @id  = id
    @title = title
    @location = location
    @description = description
    @price_per_night = price_per_night
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec("SELECT * FROM listing")
    result.map do |listing|
      Listing.new(id: listing['id'],
      title: listing['title'],
      description: listing['description'],
      location: listing['location'],
      price_per_night: listing['price_per_night'])
    end
  end
end