require 'faraday'

conn = Faraday.new(:url => 'http://0.0.0.0:4567') do |c|
  c.use Faraday::Request::UrlEncoded  # encode request params as "www-form-urlencoded"
  c.use Faraday::Response::Logger     # log request & response to STDOUT
  c.use Faraday::Adapter::NetHttp     # perform requests with Net::HTTP
end

def introduction
  puts "Welcome to the wonderful typing game.\n Please enter your name to start the game!\n When you are done, please enter 'stop'"  
  print "> "
  user = STDIN.gets.chomp()
  return user
end

def evaluate(word)

end

def start_game(user, conn)

  response = conn.get '/easy.json'

  puts response.body

end

start_game(introduction, conn)
