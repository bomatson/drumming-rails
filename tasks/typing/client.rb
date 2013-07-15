require 'faraday'
require 'json'

conn = Faraday.new(:url => 'http://0.0.0.0:9292') do |c|
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

  JSON.parse(response.body).each do |word|
  	puts "#{user}, this is word #{word[0]}"
    %x(say #{word[1]})
    # evaluate(word)
    next
  end


end

start_game(introduction, conn)
