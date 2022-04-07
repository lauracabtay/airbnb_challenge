require 'pg'

def persisted_data(table:, id:)
  connection = PG.connect(dbname: 'makersbnb_test')
  result = connection.query("SELECT * FROM users WHERE user_id = #{id};")
  result.first
end