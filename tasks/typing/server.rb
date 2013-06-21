require 'sinatra/base'

class TypeMaster < Sinatra::Base
  get '/' do
    "Hi there!"
  end
end

TypeMaster.run!