feature "Registration" do
    scenario "user registers" do
        visit('/')
        click_button('Register')
        fill_in('username', with: 'test@example.com')
        fill_in('password', with: 'password1')

        click_button('Sign up')
        expect(page).to have_content "Thank you for registering test@example.com!"
    end
end