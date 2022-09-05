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
        expect(response.body).to include("<h1>Welcome to MangoBNB</h1>")
      end
  
    
    end
end