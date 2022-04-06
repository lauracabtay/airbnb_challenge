require 'pg'

feature "search listings" do
  scenario "user can search listings by a location" do
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
    
    visit("/listings")

    fill_in('location', with: 'Camden Town')
    click_button('Search')
  

    expect(page).to have_content ('Lovely studio in Camden Town')
    expect(page).to have_content ('3 bed flat in Camden Town')
    expect(page).not_to have_content ('Large 6 bed house')
  end
end








    
    

    