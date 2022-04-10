require 'pg'

feature "register user" do
  scenario "user can register onto makersbnb" do
    connection = PG.connect(dbname: "makersbnb_test")
      
    visit("/")
    click_button('Register as a new user')
    fill_in('username', with: 'juliana1010')
    fill_in('password', with: 'password1')
    click_button('Sign up')
    
    expect(page).to have_content ("Thank you for registering juliana1010!")
  end

  scenario "user registers" do
    visit('/')
    click_button('Register')
    fill_in('username', with: 'test@example.com')
    fill_in('password', with: 'password1')

    click_button('Sign up')
    expect(page).to have_content "Thank you for registering test@example.com!"
  end
end

