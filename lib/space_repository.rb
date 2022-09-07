require_relative 'space'
require_relative 'database_connection'

class SpaceRepository
    def all
      spaces = []
  
      # Send the SQL query and get the result set.
      sql = 'SELECT id, name, description, price FROM spaces;'
      result_set = DatabaseConnection.exec_params(sql, [])
      
      # The result set is an array of hashes.
      # Loop through it to create a model
      # object for each record hash.
      result_set.each do |record|
  
        # Create a new model object
        # with the record data.
        space = Space.new
        space.id = record['id'].to_i
        space.name = record['name']
        space.description = record['description']
        space.price = record['price']
        
        spaces << space
      end
      return spaces
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
  
    def create(space)
      sql = 'INSERT INTO spaces (name, description, price) VALUES ($1, $2, $3);'
      result_set = DatabaseConnection.exec_params(sql, [space.name, space.description, space.price])
  
      return space
    end
  end