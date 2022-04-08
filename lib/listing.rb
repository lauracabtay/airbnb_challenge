require 'pg'

class Listing
  attr_reader :id, :title, :description, :location, :price_per_night, :host_id

  def initialize(id:, title:, description:, location:, price_per_night:, host_id:)
    @id  = id
    @title = title
    @location = location
    @description = description
    @price_per_night = price_per_night
    @host_id = host_id
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
      price_per_night: listing['price_per_night'],
      host_id: listing['host_id'])
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
      Listing.new(id: listing['id'], title: listing['title'], description: listing['description'], location: listing['location'], price_per_night: listing['price_per_night'], host_id: listing['host_id'])
    end
  end

  def self.create(title:, description:, location:, price_per_night:, host_id:)
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params("INSERT INTO listing (title, description, location, price_per_night, host_id) 
    VALUES ($1, $2, $3, $4, $5) 
    RETURNING id, title, description, location, price_per_night, host_id;",
    [title, description, location, price_per_night, host_id])

    Listing.new(id: result[0]['id'], title: result[0]['title'], description: result[0]['description'], 
    location: result[0]['location'], price_per_night: result[0]['price_per_night'], host_id: result[0]['host_id'])
  end

  def self.search(location:, keyword:, max_price:)
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params("SELECT * FROM listing WHERE location = $1 AND (title LIKE '%'||$2||'%' OR description LIKE '%'||$2||'%') AND price_per_night <= $3;",[location, keyword, max_price.to_f])
    result.map do |listing|
      Listing.new(id: listing['id'], title: listing['title'], description: listing['description'], location: listing['location'], price_per_night: listing['price_per_night'],host_id: listing['host_id'])
    end
  end

  def self.view_my_listings(user_id:)
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec("SELECT * FROM listing WHERE host_id = $1;", [user_id])

    result.map do |listing|
      Listing.new(id: listing['id'],
      title: listing['title'],
      description: listing['description'],
      location: listing['location'],
      price_per_night: listing['price_per_night'],
      host_id: listing['host_id'])
    end
  end

  def self.delete(id:)
    if ENV['ENVIRONMENT'] == 'test' 
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    connection.exec("DELETE FROM listing WHERE id = $1;", [id])
  end
end