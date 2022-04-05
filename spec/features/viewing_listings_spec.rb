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