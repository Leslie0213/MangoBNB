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
    also_reload 'lib/space_repository'
  end

  get '/' do
    return erb(:index)
  end

  get '/users' do
    repo = UserRepository.new
    @users = repo.all

    return erb(:display_users)
  end

  enable :sessions
  post '/users' do
    emailv = params['email']
    passwordv = params['pass_word']
    
#fetching specific users and passwords from database
    repo = UserRepository.new
    user = repo.find(emailv)

    if user == false
        #repo = UserRepository.new 
        new_user = User.new
        new_user.email = params[:email]
        new_user.pass_word = params[:pass_word]
        repo.create(new_user)
        redirect to('/confirmation')
        
    else
     # binding.irb
     session[:email_checked] = emailv
     #@email_checked=emailv 
      redirect '/signup_error'  
    end 
    
  end

  get '/signup_error' do
    #binding.irb
    @email_checked=session[:email_checked]
    return erb(:signup_error)
  end

  get '/confirmation' do
    return erb(:confirmation)
  end

  get '/login' do 
    return erb(:login)
  end

  get '/date' do 
    return erb(:date)
  end

  #Route design for spaces !!!!!

  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all

    return erb(:display_spaces)
  end

  post '/spaces' do
    repo = SpaceRepository.new
    new_space = Space.new


    new_space.name = params[:name]
    new_space.description = params[:description]
    new_space.price = params[:price]
    new_space.available_from = params[:available_from]
    new_space.available_to = params[:available_to]
    new_space.user_id = params[:user_id]
    repo.create(new_space)

    redirect '/spaces'
  end

  get '/spaces/new' do
    return erb(:create_space)
  end

  post '/login/validation' do
    #emails=[]

    #email, password returned from view
    emailv = params['email']
    passwordv = params['pass_word']
    
#fetching specific users and passwords from database
    repo = UserRepository.new
    user = repo.find(emailv)

    if user == false
      redirect '/authentication/error'   
    elsif user.email == emailv && user.pass_word == passwordv
      redirect '/spaces'
    else
      redirect '/authentication/error'  
    end

  end

  get '/authentication/error' do
    return erb(:authentication_error)
  end 

end