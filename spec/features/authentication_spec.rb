feature 'authentication' do
    it "a user can sign in" do 
    User.register(username: "laila123", password: "password123")

    visit '/'
    click_button('Sign in')
    fill_in(:username, with: 'laila123')
    fill_in(:password, with: 'password123')
    click_button('Submit')
    

    expect(page).to have_content 'Welcome laila123!'
    end
end