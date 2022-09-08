

require "spec_helper"
require "rack/test"
require_relative "../../app"

describe Application do
    include Rack::Test::Methods
  
    let(:app) { Application.new }
  
    context "GET /" do
      it 'displays the signup/login page to the user' do
       
        response = get('/')
  
        expect(response.status).to eq(200)
        expect(response.body).to include("<h1>mangobnb</h1>")
      end
    end

    context 'POST /users' do
      it 'creates a new user in the database' do
        response = post('/users', email: 'razbugoi@gmail.com', pass_word: '123asd')
  
        expect(response.status).to eq 302
        expect(response.body).to eq ''

        response = get('/users')
  
        expect(response.body).to include('razbugoi@gmail.com')
      end
    end

    context "GET /spaces" do
        it 'displays all the spaces post successful user login' do
         
          response = get('/spaces')
    
          expect(response.status).to eq(200)
          expect(response.body).to include("<h1>Spaces Listed</h1>")
        end
      end

      context 'POST /spaces' do
        it 'creates a new space in the database' do
          response = post('/spaces', name: 'Holiday Cottages', description: 'Nice cozy cottages', price: '120', available_from: '2022-09-20', available_to: '2022-12-25', user_id: '1')
    
          expect(response.status).to eq 302
          expect(response.body).to eq ""
    
          response = get('/spaces')
    
          expect(response.body).to include('Holiday Cottages')
        end
      end

      context 'GET /signup_error' do
        it 'returns an error if the username already exists in the database' do
          response = get('/signup_error')
    
          expect(response.status).to eq 200
          expect(response.body).to include('Please use different username')
        end
      end

      context 'GET /confirmation' do
        it 'returns a confirmation message if the account has been created' do
          response = get('/confirmation')
    
          expect(response.status).to eq 200
          expect(response.body).to include('<h1>Account created successfully! You can now <a href="/login">log in</a></h1>')
        end
      end

      context 'GET /login' do
        it 'returns the log in page' do
          response = get('/login')
    
          expect(response.status).to eq 200
          expect(response.body).to include('<h1>Log in to MangoBnB</h1>')
        end
      end

      context 'GET /spaces/new' do
        it 'returns the create space page where user can add a new space to the database' do
          response = get('/spaces/new')
    
          expect(response.status).to eq 200
          expect(response.body).to include('<button type="submit" class="btn btn-primary">Create Space</button>')
        end
      end

      context 'POST /login/validation' do
        it 'checks if the user credentials match the data in the database' do
          response = post('/login/validation', email: 'raz@razbugoi.co.uk', pass_word: 'rxcvx21@!*&')
    
          expect(response.status).to eq 302
          expect(response.body).to eq ""
    
          response = get('/spaces')
    
          expect(response.body).to include('The Old Bakery')
        end
      end

      context 'POST /login/validation' do
        it 'returns an error page if the credentials are incorrect' do
          response = post('/login/validation', email: 'razasd231@razbugoi.co.uk', pass_word: 'rxcvxvcbvbx21@!*&')
    
          expect(response.status).to eq 302
          expect(response.body).to eq ""
    
          response = get('/authentication/error')
    
          expect(response.body).to include('<h1>UserID or Password incorrect <a href="/login">Please try again</a> </h1>')
        end
      end

      context 'GET /authentication/error' do
        it 'returns an error message if the authentication fails' do
          response = get('/authentication/error')
    
          expect(response.status).to eq 200
          expect(response.body).to include('<h1>UserID or Password incorrect <a href="/login">Please try again</a> </h1>')
        end
      end
end