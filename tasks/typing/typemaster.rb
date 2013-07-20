require 'json'
require 'random-word'
require 'sinatra/base'

class TypeMaster < Sinatra::Base
  get '/typemaster-flex' do
    haml :client
  end

  get '/level/:difficulty' do
  	content_type :json
    adjectives = case params[:difficulty]
    when 'hard'
      RandomWord.adjs.to_a.take(50)
    when 'medium'
      RandomWord.adjs.to_a.take(25)
    else
      RandomWord.adjs.to_a.take(5)
    end

  	hash = Hash[adjectives.each_with_index.map{|word, idx| [idx, word]}]
  	hash.to_json
  end
end
