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
  enable :sessions
  get '/' do
    return erb(:index)
  end

  get '/users' do
    repo = UserRepository.new
    @users = repo.all

    return erb(:display_users)
  end

  
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

    @user_name=session[:user_name] 
   #binding.irb
   if @user_name==nil
    redirect '/session/invalid'
   else
    return erb(:confirmation)
   end
  end

  get '/login' do 
    return erb(:login)
  end

  get '/date' do 

    @user_name=session[:user_name] 
    #binding.irb
    if @user_name==nil
     redirect '/session/invalid'
    else

    @name=params["name"]
    @description=params["description"]
    @price=params["price"]
    @available_from=params["from"]
    @available_from=@available_from.split("-").reverse().join("/")
    date_from = Date.strptime(@available_from, '%d/%m/%Y')
    @available_from= date_from.strftime('%m/%d/%Y')

    @available_to=params["to"]
    @available_to=@available_to.split("-").reverse().join("/")
    date_to = Date.strptime(@available_to, '%d/%m/%Y')
    @available_to= date_to.strftime('%m/%d/%Y')
    @user_id=params["id"]
    #binding.irb
    return erb(:date)

    end
  end

  post '/booking/confirmation' do
    #binding.irb
    @user_name=session[:user_name] 
    #binding.irb
    if @user_name==nil
     redirect '/session/invalid'
    else
    @name=params["name"]
    @daterange=params["daterange"]
    return erb(:booking_confirmation)
    end
  end

  post '/date' do 

    #binding.irb
    return erb(:date)
  end

  get '/session/invalid' do
    return erb(:invalid_session)
  end

  #Route design for spaces !!!!!

  get '/spaces' do
    @user_name=session[:user_name] 
   #binding.irb
   if @user_name==nil
    redirect '/session/invalid'
   else
    repo = SpaceRepository.new
    @spaces = repo.all

    return erb(:display_spaces)
   end
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
    @user_name=session[:user_name] 
   #binding.irb
   if @user_name==nil
    redirect '/session/invalid'
   else
    return erb(:create_space)
   end
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
      #Declare session variable here !!!!
      session[:user_name] = user.email
      #<%= @email_checked %>
      redirect '/spaces'
    else
      redirect '/authentication/error'  
    end

  end

  get '/authentication/error' do
    return erb(:authentication_error)
  end 

end