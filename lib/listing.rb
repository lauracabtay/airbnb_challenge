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

  def self.find_property_by_id(id:)
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec("SELECT * FROM listing WHERE id = $1;", [id])
    result.map do |listing|
      Listing.new(id: listing['id'], title: listing['title'], description: listing['description'], location: listing['location'], price_per_night: listing['price_per_night'])
    end
  end

  def self.create(title:, description:, location:, price_per_night:)
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params("INSERT INTO listing (title, description, location, price_per_night) 
    VALUES ($1, $2, $3, $4) 
    RETURNING id, title, description, location, price_per_night;",
    [title, description, location, price_per_night])

    Listing.new(id: result[0]['id'], title: result[0]['title'], description: result[0]['description'], 
    location: result[0]['location'], price_per_night: result[0]['price_per_night'])
  end

  def self.search(location:, keyword:)
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params("SELECT * FROM listing WHERE location = $1 AND title LIKE %'$2'%;",[location, keyword])
    result.map do |listing|
      Listing.new(id: listing['id'], title: listing['title'], description: listing['description'], location: listing['location'], price_per_night: listing['price_per_night'])
    end
  end
end