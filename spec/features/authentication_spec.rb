feature 'authentication' do
    scenario "a user can sign in" do 
    User.register(username: "laila123", password: "password123")

    visit '/'
    click_button('Sign in')
    fill_in(:username, with: 'laila123')
    fill_in(:password, with: 'password123')
    click_button('Submit')
    
    expect(page).to have_content 'Welcome laila123!'
    end

    scenario "username is not correct" do
        User.register(username:"random123", password: "randompassword")
        visit '/'
        click_button('Sign in')
        fill_in(:username, with: 'laila123')
        fill_in(:password, with: 'randompassword')
        click_button('Submit')
    

        expect(page).to have_content 'Wrong username or password. Try again or register now.'
        expect(page).not_to have_content 'Welcome random123!'
    end

    scenario "password is incorrect" do
        User.register(username:"laila123", password: "randompassword")
        visit '/'
        click_button('Sign in')
        fill_in(:username, with: 'laila123')
        fill_in(:password, with: 'password')
        click_button('Submit')

        expect(page).to have_content 'Wrong username or password. Try again or register now.'
        expect(page).not_to have_content 'Welcome laila123!'
    end

    scenario "user can sign out" do
        User.register(username:"laila123", password: "randompassword")
        visit '/'
        click_button('Sign in')
        fill_in(:username, with: 'laila123')
        fill_in(:password, with: 'randompassword')
        click_button('Submit')
        click_button('Sign out')

        expect(page).to have_content "You have signed out."
        expect(page).not_to have_content 'Welcome, test@example.com'
    end
end