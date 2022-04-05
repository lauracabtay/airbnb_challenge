require 'pg'

def setup_test_database
  p "Setting up test database..."
    connection = PG.connect(dbname: 'makersbnb_test')
    # Clear the listing table
    connection.exec("TRUNCATE listing;")
    # Clear the listing table
    connection.exec("TRUNCATE booking;")
    # Clear the listing table
    connection.exec("TRUNCATE calendar;")
    # Clear the listing table
    connection.exec("TRUNCATE users;")
    # Clear the listing table
    connection.exec("TRUNCATE hosts;")
end