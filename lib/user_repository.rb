require_relative 'user'

class UserRepository
    def all
      users = []
  
      # Send the SQL query and get the result set.
      sql = 'SELECT id, email, pass_word FROM users;'
      result_set = DatabaseConnection.exec_params(sql, [])
      
      # The result set is an array of hashes.
      # Loop through it to create a model
      # object for each record hash.
      result_set.each do |record|
  
        # Create a new model object
        # with the record data.
        user = User.new
        user.id = record['id'].to_i
        user.email = record['email']
        user.pass_word = record['pass_word']
  
        users << user
      end
  
      return users
    end
  
    # def find(id)
    #   sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    #   result_set = DatabaseConnection.exec_params(sql, [id])
  
    #   artist = Artist.new
    #   artist.id = result_set[0]['id'].to_i
    #   artist.name = result_set[0]['name']
    #   artist.genre = result_set[0]['genre']
  
    #   return artist
    # end
  
    def create(user)
      sql = 'INSERT INTO users (email, pass_word) VALUES ($1, $2);'
      result_set = DatabaseConnection.exec_params(sql, [user.email, user.pass_word])
  
      return user
    end
  end