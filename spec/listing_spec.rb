require 'listing'

RSpec.describe Listing do
  describe '.all' do
    it "view all listings" do
      connection = PG.connect(dbname: "makersbnb_test")
      connection.exec("INSERT INTO listing (title, description, location, price_per_night)
    values (
            '2 bed apartment',
            'Lorem ipsum dolor sit amet',
            'London',
            350.00
        );")
      connection.exec("insert into listing (title, description, location, price_per_night)
    values (
            'Lovely studio in Camden Town',
            'Lorem ipsum dolor sit amet.',
            'London',
            280.00
        );")
      listing_view = Listing.all
      expect(listing_view.length).to eq 2
      expect(listing_view.count).to eq 2
      expect(listing_view.first).to be_a Listing
      expect(listing_view.first.title).to eq "2 bed apartment"
    end
  end

  describe '.create' do
    it "creates a new listing" do
      connection = PG.connect(dbname: "makersbnb_test")
      user1 = connection.exec("INSERT INTO users (username, password) values ('laila123', 'password') RETURNING user_id;")
      Listing.create(title: 'Luxury apartment in Chelsea', description: 'Lorem ipsum dolor sit amet.', location: 'London', price_per_night: 600.00, host_id: user1[0]['user_id'])

      listings = Listing.all

      expect(listings.length).to eq 1
      expect(listings.first).to be_a Listing
      expect(listings.first.title). to eq 'Luxury apartment in Chelsea'
      expect(listings.first.location). to eq 'London'
      expect(listings.first.price_per_night). to eq "600.00"
    end
  end

  describe '.find_property_by_id' do
    it "pulls the details of a specific property" do
        connection = PG.connect(dbname: "makersbnb_test")
        user1 = connection.exec("INSERT INTO users (username, password) values ('laila123', 'password') RETURNING user_id;")
        new_listing = Listing.create(title: 'Luxury apartment in Chelsea', description: 'Lorem ipsum dolor sit amet.', location: 'London', price_per_night: 600.00, host_id: user1[0]['user_id'])
        listing = Listing.find_property_by_id(id: new_listing.id)

        expect(listing.length).to eq 1
        expect(listing.first).to be_a Listing
        expect(listing.first.title). to eq 'Luxury apartment in Chelsea'
        expect(listing.first.location). to eq 'London'
        expect(listing.first.price_per_night). to eq "600.00"
    end
  end

  describe '.search' do
    it "pulls the listings according to location" do
      connection = PG.connect(dbname: "makersbnb_test")
      user1 = connection.exec("INSERT INTO users (username, password) values ('laila123', 'password') RETURNING user_id;")
      
      Listing.create(title: '2 bed  apartment', description: 'Lorem ipsum dolor sit amet', location: 'Hackney', price_per_night: 350.00, host_id: user1[0]['user_id'])
      Listing.create(title: 'Lovely studio in Camden Town', description: 'Lorem ipsum dolor sit amet.', location: 'Camden Town', price_per_night: 280.00, host_id: user1[0]['user_id'])
      Listing.create(title: '3 bed flat in Camden Town', description: 'Lorem ipsum dolor sit amet.', location: 'Camden Town', price_per_night: 900.00, host_id: user1[0]['user_id'])
      Listing.create(title: 'Large 6 bed house', description: 'Lorem ipsum dolor sit amet.', location: 'Harlesden', price_per_night: 800.00, host_id: user1[0]['user_id'])

      listing = Listing.search(location: "Camden Town", keyword:"studio", max_price: 600.00)
      expect(listing.length).to eq 1
      expect(listing.first.title).to eq 'Lovely studio in Camden Town'
      expect(listing.first.location).to eq 'Camden Town'
    end

    it "pulls the listings according to price" do
      connection = PG.connect(dbname: "makersbnb_test")
      user1 = connection.exec("INSERT INTO users (username, password) values ('laila123', 'password') RETURNING user_id;")
      Listing.create(title: '2 bed  apartment', description: 'ipsum dolor sit amet', location:'London', price_per_night: 350.00, host_id: user1[0]['user_id'])
      Listing.create(title: 'Lovely studio in Camden Town', description: 'Lorem ipsum dolor sit amet', location:'London', price_per_night: 280.00, host_id: user1[0]['user_id'])
      Listing.create(title: '3 bed flat in Camden Town', description: 'Lorem ipsum dolor sit amet', location:'Camden Town', price_per_night: 900.00, host_id: user1[0]['user_id'])
      Listing.create(title: 'Large 6 bed house', description: 'Lorem ipsum dolor sit amet', location:'Harlesden', price_per_night: 800.00, host_id: user1[0]['user_id'])

      listing = Listing.search(location:"London", keyword:"studio", max_price: 300.00)
      expect(listing.length).to eq 1 
      expect(listing.first.title).to eq 'Lovely studio in Camden Town'
      expect(listing.first.location).to eq 'London'
      expect(listing.first.description).to eq 'Lorem ipsum dolor sit amet'

      listing2 = Listing.search(location:"London", keyword:"Lorem", max_price: 300.00)
      expect(listing2.length).to eq 1 
      expect(listing2.first.title).to eq 'Lovely studio in Camden Town'
      expect(listing2.first.location).to eq 'London'
      expect(listing2.first.description).to eq 'Lorem ipsum dolor sit amet'

      listing3 = Listing.search(location:"London", keyword:"ipsum", max_price: 400.00)
      expect(listing3.length).to eq 2
      expect(listing3.first.title).to eq '2 bed  apartment'
      expect(listing3.first.location).to eq 'London'
      expect(listing3.first.description).to eq 'ipsum dolor sit amet'
      expect(listing3.last.title).to eq 'Lovely studio in Camden Town'
    end
  end

  describe ".view_my_listings" do
    it "allows a host to view their listings" do
      connection = PG.connect(dbname: "makersbnb_test")
      user1 = connection.exec("INSERT INTO users (username, password) values ('laila123', 'password') RETURNING user_id;")
      user2 = connection.exec("INSERT INTO users (username, password) values ('random123', 'password123') RETURNING user_id;")

      listing1 = Listing.create(title: '2 bed apartment', description: 'ipsum dolor sit amet', location:'London', price_per_night: 350.00, host_id: user1[0]['user_id'])
      listing2 = Listing.create(title: 'Lovely studio in Camden Town', description: 'Lorem ipsum dolor sit amet', location:'London', price_per_night: 280.00, host_id: user2[0]['user_id'])

      my_listings = Listing.view_my_listings(user_id: user1[0]['user_id'])

      expect(my_listings.length).to eq 1
      expect(my_listings.first.title).to eq '2 bed apartment'
    end
  end

  describe ".delete" do
    it "allows a host to delete a listing" do
      connection = PG.connect(dbname: "makersbnb_test")
      user1 = connection.exec("INSERT INTO users (username, password) values ('laila123', 'password') RETURNING user_id;")

      listing1 = Listing.create(title: '2 bed apartment', description: 'ipsum dolor sit amet', location:'London', price_per_night: 350.00, host_id: user1[0]['user_id'])
      listing2 = Listing.create(title: 'Lovely studio in Camden Town', description: 'Lorem ipsum dolor sit amet', location:'London', price_per_night: 280.00, host_id: user1[0]['user_id'])

      Listing.delete(id: listing1.id)
      my_listings = Listing.view_my_listings(user_id: user1[0]['user_id'])

      expect(my_listings.length).to eq 1
      expect(my_listings.first.title).to eq 'Lovely studio in Camden Town'
    end
  end
end