require 'json'
require 'random-word'
require 'sinatra'

class TypeMaster < Sinatra::Base
  get '/typemaster-flex' do
    haml :client
  end

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


