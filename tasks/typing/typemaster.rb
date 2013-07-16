require 'json'
require 'random-word'
require 'sinatra/base'

class TypeMaster < Sinatra::Base
  get '/typemaster-flex' do
    haml :client
  end

  get '/easy.json' do
  	content_type :json
  	arr = RandomWord.adjs.to_a.take(5)

  	hash = Hash[arr.each_with_index.map{|value, idx| [idx, value]}]
  	# hash = Hash[arr.map{|value| words: {value}}]
  	hash.to_json
  end
end