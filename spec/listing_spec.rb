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
      Listing.create(title: 'Luxury apartment in Chelsea', description: 'Lorem ipsum dolor sit amet.', location: 'London', price_per_night: 600.00)

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
        new_listing = Listing.create(title: 'Luxury apartment in Chelsea', description: 'Lorem ipsum dolor sit amet.', location: 'London', price_per_night: 600.00)
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
      connection.exec("INSERT INTO listing (title, description, location, price_per_night)
      values (
              '2 bed  apartment',
              'Lorem ipsum dolor sit amet',
              'Hackney',
              350.00
          );")
      connection.exec("insert into listing (title, description, location, price_per_night)
      values (
              'Lovely studio in Camden Town',
              'Lorem ipsum dolor sit amet.',
              'Camden Town',
              280.00
          );")
      connection.exec("insert into listing (title, description, location, price_per_night)
      values (
              '3 bed flat in Camden Town',
              'Lorem ipsum dolor sit amet.',
              'Camden Town',
              900.00
          );")
  
      connection.exec("insert into listing (title, description, location, price_per_night)
      values (
              'Large 6 bed house',
              'Lorem ipsum dolor sit amet.',
              'Harlesden',
              800.00
          );")

      listing = Listing.search(location: "Camden Town", keyword:"studio", max_price: 600.00)
      expect(listing.length).to eq 1
      expect(listing.first.title).to eq 'Lovely studio in Camden Town'
      expect(listing.first.location).to eq 'Camden Town'
    end

    it "pulls the listings according to price" do
      Listing.create(title: '2 bed  apartment', description: 'ipsum dolor sit amet', location:'London', price_per_night: 350.00)
      Listing.create(title: 'Lovely studio in Camden Town', description: 'Lorem ipsum dolor sit amet', location:'London', price_per_night: 280.00)
      Listing.create(title: '3 bed flat in Camden Town', description: 'Lorem ipsum dolor sit amet', location:'Camden Town', price_per_night: 900.00)
      Listing.create(title: 'Large 6 bed house', description: 'Lorem ipsum dolor sit amet', location:'Harlesden', price_per_night: 800.00)

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
end