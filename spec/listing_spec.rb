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
      # connection = PG.connect(dbname: 'makersbnb_test')

      Listing.create(title: 'Luxury apartment in Chelsea', description: 'Lorem ipsum dolor sit amet.', location: 'London', price_per_night: 600.00)

      listings = Listing.all

      expect(listings.length).to eq 1
      expect(listings.first).to be_a Listing
      expect(listings.first.title). to eq 'Luxury apartment in Chelsea'
      expect(listings.first.location). to eq 'London'
      expect(listings.first.price_per_night). to eq "600.00"
    end
  end
end