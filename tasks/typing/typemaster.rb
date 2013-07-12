require 'json'
require 'random-word'
require 'sinatra/base'

class TypeMaster < Sinatra::Base
  get '/typemaster-flex' do
    haml :client
  end

  get '/easy.json' do
  	content_type :json
  	{ :test => 'test' }.to_json
    # RandomWord.adjs.to_a.take(100)
  end
end