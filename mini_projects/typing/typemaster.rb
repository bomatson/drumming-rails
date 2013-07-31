require 'json'
require 'random-word'
require 'sinatra'

class TypeMaster < Sinatra::Base

  before do
    @heading = "Typemaster Flex"
  end

  get '/typemaster-flex' do
    haml :client
  end

  #example:
  
  get '/user/:first/?:last?' do 
    "Your input is #{params[:first]} #{params[:last]}"
  end

  get '/:answer' do
    #check if input matches word
  end

  #right now I get an array of answers that I can render in a view
  #using an instance variable
  #I need a way to accept an input and post an answer
  #which will then check if the input matches the word 

  get '/level/:difficulty' do
  	content_type :json

    adjs = RandomWord.adjs.to_a.take(100)

    adjectives = case params[:difficulty]
    when 'hard'
      adjs.select {|word| word.size > 10}
    when 'medium'
      med = adjs.select {|word| word.size <= 10 && word.size > 5 }
      med[0..24]
    else
      easy = adjs.select {|word| word.size <= 5}
      easy[0..4]
    end
    adjectives.to_json
  end
end


