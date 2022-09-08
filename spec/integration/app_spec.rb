

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
  
        expect(response.status).to eq 200
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
          response = post('/spaces', name: 'Holiday Cottages', description: 'Nice cozy cottages', price: '120', user_id: '1')
    
          expect(response.status).to eq 302
          expect(response.body).to eq ""
    
          response = get('/spaces')
    
          expect(response.body).to include('Holiday Cottages')
        end
      end
end