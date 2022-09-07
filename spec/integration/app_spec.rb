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

    # context 'GET /session/new' do
    #   it 'returns the HTML form to log in as a user' do
    #     response = get('/session/new')
  
    #     expect(response.status).to eq 200
    #     expect(response.body).to include('<form method="POST" action="/users">')
    #     expect(response.body).to include('<input type="text" name="email" />')
    #     expect(response.body).to include('<input type="text" name="pass_word" />')
    #   end
    # end
end