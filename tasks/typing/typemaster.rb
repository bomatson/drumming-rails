require 'json'
require 'random-word'
require 'sinatra/base'

class TypeMaster < Sinatra::Base
  get '/typemaster-flex' do
    haml :client
  end

  get '/level/:difficulty' do
  	content_type :json
    if params[:difficulty] == 'medium'
      arr = RandomWord.adjs.to_a.take(25)
    else
      arr = RandomWord.adjs.to_a.take(5)
    end

  	hash = Hash[arr.each_with_index.map{|value, idx| [idx, value]}]
  	# hash = Hash[arr.map{|value| words: {value}}]
  	hash.to_json
  end
end