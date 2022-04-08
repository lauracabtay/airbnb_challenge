require 'pg'

feature "search listings" do
  scenario "user can search listings by location, keyword and max-price" do
    connection = PG.connect(dbname: "makersbnb_test")
    user1 = connection.exec("INSERT INTO users (username, password) values ('laila123', 'password') RETURNING user_id;")

    Listing.create(title: '2 bed apartment', description: 'Lorem ipsum dolor sit amet', location:'London', price_per_night: 350.00, host_id: user1[0]['user_id'])
    Listing.create(title: 'Lovely studio in Camden Town', description: 'Lorem ipsum dolor sit amet', location:'Camden Town', price_per_night: 280.00, host_id: user1[0]['user_id'])
    Listing.create(title: '3 bed flat in Camden Town', description: 'Lorem ipsum dolor sit amet', location:'Camden Town', price_per_night: 900.00, host_id: user1[0]['user_id'])
    Listing.create(title: 'Large 6 bed house', description: 'Lorem ipsum dolor sit amet', location:'Harlesden', price_per_night: 800.00, host_id: user1[0]['user_id'])
    
    visit("/listings")
    fill_in('location', with: 'Camden Town')
    fill_in('keyword', with: 'studio')
    fill_in('max_price', with: '600')
    click_button('Search')
  
    expect(page).to have_content ('Lovely studio in Camden Town')
    expect(page).not_to have_content ('3 bed flat in Camden Town')
    expect(page).not_to have_content ('Large 6 bed house')
  end

  scenario 'user can search listing by keyword and max price' do 
    connection = PG.connect(dbname: "makersbnb_test")
    user1 = connection.exec("INSERT INTO users (username, password) values ('laila123', 'password') RETURNING user_id;")
    
    Listing.create(title: '2 bed  apartment', description: 'Lorem ipsum dolor sit amet', location:'London', price_per_night: 350.00, host_id: user1[0]['user_id'])
    Listing.create(title: 'Lovely studio in Camden Town', description: 'Lorem ipsum dolor sit amet', location:'London', price_per_night: 280.00, host_id: user1[0]['user_id'])
    
    visit("/listings")
    fill_in('location', with: 'London')
    fill_in('keyword', with: 'studio')
    fill_in('max_price', with: '600')
    click_button('Search')

    expect(page).to have_content ('Lovely studio in Camden Town')
    expect(page).not_to have_content ('2 bed  apartment')
  end

  scenario 'user can search listing by price' do 

    connection = PG.connect(dbname: "makersbnb_test")
    user1 = connection.exec("INSERT INTO users (username, password) values ('laila123', 'password') RETURNING user_id;")
    
    Listing.create(title: '2 bed apartment', description: 'Lorem ipsum dolor sit amet', location:'London', price_per_night: 350.00, host_id: user1[0]['user_id'])
    Listing.create(title: 'Lovely studio in Camden Town', description: 'Lorem ipsum dolor sit amet', location:'London', price_per_night: 280.00, host_id: user1[0]['user_id'])
    Listing.create(title: '3 bed flat in Camden Town', description: 'Lorem ipsum dolor sit amet', location:'Camden Town', price_per_night: 900.00, host_id: user1[0]['user_id'])
    Listing.create(title: 'Large 6 bed house', description: 'Lorem ipsum dolor sit amet', location:'Harlesden', price_per_night: 800.00, host_id: user1[0]['user_id'])
    visit("/listings")
    fill_in('location', with: 'London')
    fill_in('keyword', with: 'studio')
    fill_in('max_price', with: '600')
    click_button('Search')

    expect(page).to have_content ('Lovely studio in Camden Town')
    expect(page).not_to have_content ('2 bed apartment')
    expect(page).not_to have_content ('3 bed flat in Camden Town')
    expect(page).not_to have_content ('800')
  end
end
 