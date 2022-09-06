require "user_repository"
require "user"


def reset_users_table
  seed_sql = File.read('seeds/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'mangobnb_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  it 'finds all the users' do
    repo = UserRepository.new

    users = repo.all
    
    expect(users.length).to eq(4)
    expect(users.first.email).to eq('rex@rex.com')
  end

#   it 'finds one artist' do
#     repo = ArtistRepository.new

#     artist = repo.find(3)
    
#     expect(artist.id).to eq(3)
#     expect(artist.name).to eq('Taylor Swift')
#   end

  it 'creates an user' do
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