# file: app.rb
require_relative 'lib/user_repository'
require_relative 'lib/user'
require_relative 'lib/space_repository'
require_relative 'lib/space'
require_relative 'lib/database_connection'
require 'sinatra/base'
require 'sinatra/reloader'

DatabaseConnection.connect

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/user_repository'
    # also_reload 'lib/artist_repository'
  end

  get '/' do
    return erb(:index)
  end

  get '/users' do
    repo = UserRepository.new
    @users = repo.all

    return erb(:display_users)
  end

  post '/users' do
    repo = UserRepository.new
    new_user = User.new


    new_user.email = params[:email]
    new_user.pass_word = params[:pass_word]

    repo.create(new_user)

    return erb(:sign_up_confirmation)
  end

  #Route design for spaces !!!!!

  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all

    return erb(:display_spaces)
  end



end