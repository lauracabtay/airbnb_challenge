require 'pg'

def setup_test_database
  p "Setting up test database..."
    connection = PG.connect(dbname: 'makersbnb_test')
    # Clear the tables
    connection.exec("TRUNCATE listing, booking, calendar, users, hosts;")
end