require 'pg'

feature "create new listing" do
    scenario "a host creates a new listing" do
        visit('/listings')
        click_button('Create a new listing')
        fill_in('title', with: 'Luxury apartment in Chelsea')
        fill_in('description', with: 'Lorem ipsum dolor sit amet.')
        fill_in('location', with: 'London')
        fill_in('price_per_night', with: 600.00)

        click_button('Submit')

        expect(page).to have_content ('Luxury apartment in Chelsea')
        expect(page).to have_content ('Lorem ipsum dolor sit amet.')
        expect(page).to have_content ('London')
        expect(page).to have_content ('600')
    end

    scenario "a host creates a new listing and can see \"My listings\" button on main page " do

        visit('/')
        click_button('Register as a new user')
        fill_in('username', with: 'lauracab1')
        fill_in('password', with: 'password')
        click_button('Sign up')
        click_button('Listings')
        click_button('Create a new listing')
        fill_in('title', with: 'Luxury apartment in Chelsea')
        fill_in('description', with: 'Lorem ipsum dolor sit amet.')
        fill_in('location', with: 'London')
        fill_in('price_per_night', with: 600.00)

        click_button('Submit')
        click_button('Back to all listings')
        click_button('My listings')

        expect(page).to have_content ('Luxury apartment in Chelsea')
        expect(page).to have_content ('London')
        expect(page).to have_content ('600')
    end
end