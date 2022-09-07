# file: app.rb
require_relative 'lib/user_repository'
require_relative 'lib/user'
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
    if invalid_request_parameters?
      status 400
      return ''
    end
    
    repo = UserRepository.new
    new_user = User.new


    new_user.email = params[:email]
    new_user.pass_word = params[:pass_word]

    repo.create(new_user)

    redirect to('/confirmation')
  end

  get '/confirmation' do
    return erb(:confirmation)
  end

  get '/login' do 
    return erb(:login)
  end

  get '/spaces' do
    return erb(:spaces)
  end

  def invalid_request_parameters? 
    return (params[:email] == nil || params[:pass_word] == nil)
  end
end