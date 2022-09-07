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

  xit 'creates an user' do
    repo = UserRepository.new

    user = User.new
    user.email = 'maria@maria.com'
    user.pass_word = 'maria@123'
    repo.create(user)

    users = repo.all

    expect(users.length).to eq(5)
    expect(users.last.email).to eq('maria@maria.com')
  end
end