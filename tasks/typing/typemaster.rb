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
    adjectives.to_json
  end
end


# adjs = RandomWord.adjs.to_a.take(100)
# longer_words = adjs.select {|word| word.size > 10}
# in_the_thousand_most common
# outside_the_most_commmon
