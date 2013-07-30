require_relative 'typemaster.rb'
require 'rspec'
require 'rack/test'

set :environment, :test

describe 'Typemaster Flex' do
	include Rack::Test::Methods

	def app
	  TypeMaster.new
	end

	describe 'home page' do

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

	describe 'easy level' do

		before(:each) do
			get '/level/easy'
			@response = JSON.parse(last_response.body)
		end

		it 'should return an array' do
			@response.should be_kind_of(Array)
		end

		it 'should return 5 words' do
			@response.length.should eq(5)
		end
	end

	describe 'medium level' do

		before(:each) do
			get '/level/medium'
			@response = JSON.parse(last_response.body)
		end

		it 'should return 25 words' do
			@response.length.should eq(25)
		end
	end

	describe 'hard level' do

		before(:each) do
			get '/level/hard'
			@response = JSON.parse(last_response.body)
		end

		it 'should return 50 words' do
			@response.length.should eq(50)
		end
	end
end