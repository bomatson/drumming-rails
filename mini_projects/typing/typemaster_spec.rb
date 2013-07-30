require_relative 'typemaster.rb'
require 'rspec'
require 'rack/test'

set :environment, :test

#I'm getting an error trying to use set:
# undefined method `set' for main:Object

def app
  Sinatra::Application
end

describe 'Typemaster flex home page' do
	include Rack::Test::Methods

	before(:each) do
		get '/typemaster-flex'
	end

	it 'should be ok' do
		last_response.status.should == 200
	end

	it 'should be return a message' do
		last_response.body.should include('I will spit out words')
	end
end