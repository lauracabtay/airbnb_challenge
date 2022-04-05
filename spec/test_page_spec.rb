feature 'visiting home page' do 
    scenario 'it shows Test' do 
        visit('/')
        expect(page).to have_content('Test')
    end 
end
