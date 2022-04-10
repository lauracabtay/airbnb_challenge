require 'pg'

feature "view listing" do
  scenario "user can view all listings" do
    connection = PG.connect(dbname: "makersbnb_test")
    connection.exec("INSERT INTO listing (title, description, location, price_per_night)
    values (
            '2 bed  apartment',
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
    visit("/listings")
    expect(page).to have_content ("London")
    expect(page).to have_content ("Lovely studio in Camden Town")
    expect(page).to have_content ("350")
  end 
end

feature "view listing by id" do
  scenario "user can view details for a specific listing" do
    connection = PG.connect(dbname: "makersbnb_test")
    user1 = connection.exec("INSERT INTO users (username, password) values ('laila123', 'password') RETURNING user_id;")
    property1 = Listing.create(title: '2 bed  apartment', description: 'Lorem ipsum dolor sit amet', location:'London', price_per_night: 350.00, host_id: user1[0]['user_id'])
    property2 = Listing.create(title: 'Lovely studio in Camden Town', description: 'Lorem ipsum dolor sit amet', location:'London', price_per_night: 280.00, host_id: user1[0]['user_id'])
    
    visit("/listings")
    expect(page).to have_link("2 bed apartment", :href => "../listings/#{property1.id}")
    expect(page).to have_link("Lovely studio in Camden Town", :href => "../listings/#{property2.id}")

    click_on('2 bed apartment')

    expect(page).to have_content ("2 bed apartment")
    expect(page).to have_content ("London")
    expect(page).to have_content ("Lorem ipsum dolor sit amet")
    expect(page).to have_content ("350.00")
  end 
end