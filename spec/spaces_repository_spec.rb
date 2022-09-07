require "space_repository"
require "space"


def reset_space_table
  seed_sql = File.read('seeds/seeds_spaces.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'mangobnb_test' })
  connection.exec(seed_sql)
end

describe SpaceRepository do
  before(:each) do 
    reset_space_table
  end

  it 'finds all the users' do
    repo = SpaceRepository.new

    spaces = repo.all
    
    expect(spaces.length).to eq(7)
    expect(spaces.first.name).to eq('Swaines Cottage')
  end

#   it 'finds one artist' do
#     repo = ArtistRepository.new

#     artist = repo.find(3)
    
#     expect(artist.id).to eq(3)
#     expect(artist.name).to eq('Taylor Swift')
#   end

  it 'creates a new space' do
    repo = SpaceRepository.new

    space = Space.new
    space.name = 'Holiday Cottages'
    space.description = 'nice cozy cottages'
    space.price = 120
    space.user_id = 1
    repo.create(space)

    spaces = repo.all

    expect(spaces.length).to eq(8)
    expect(spaces.last.name).to eq('Holiday Cottages')
  end
end