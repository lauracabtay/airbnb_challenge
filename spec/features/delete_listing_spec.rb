feature "delete listing" do
    scenario "a host can delete a listing" do
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
        click_button('Delete')

        expect(page).not_to have_content 'Luxury apartment in Chelsea'
    end
end