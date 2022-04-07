require 'bcrypt'

class User

    attr_reader :user_id, :username

    def initialize(user_id:, username:)
        @user_id = user_id
        @username = username
    end

    def self.register(username:, password: )
        if ENV['ENVIRONMENT'] == 'test' 
            connection = PG.connect(dbname: "makersbnb_test")
        else
            connection = PG.connect(dbname: 'makersbnb')
        end

        encrypted_password = BCrypt::Password.create(password)

        result = connection.exec_params("INSERT INTO users (username, password)
        VALUES ($1, $2)
        RETURNING user_id, username, password;",[username, encrypted_password])

        User.new(user_id: result[0]['user_id'], username: result[0]['username'])
    end

    def self.authenticate(username:, password:)
        if ENV['ENVIRONMENT'] == 'test' 
            connection = PG.connect(dbname: "makersbnb_test")
        else
            connection = PG.connect(dbname: 'makersbnb')
        end

        result = connection.query(
            "SELECT * FROM users WHERE username = $1",
            [username]
          )

        User.new(user_id: result[0]['user_id'], username: result[0]['username'])
    end
end
