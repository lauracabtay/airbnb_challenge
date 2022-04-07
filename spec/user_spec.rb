require 'user'

RSpec.describe User do
    describe '.register' do
        it "it allows a new user to be created" do
        user1 = User.register(username: 'juliana1010', password: "password1")

        expect(user1.username).to eq 'juliana1010'
        expect(user1).to be_a User
        end
    end
end

            
            
    