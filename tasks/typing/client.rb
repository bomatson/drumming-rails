require 'faraday'
require 'json'

SUCCESSES = []
FAILURES = []
#rackup config.ru --port=4567
conn = Faraday.new(:url => 'http://0.0.0.0:4567') do |c|
  c.use Faraday::Request::UrlEncoded  # encode request params as "www-form-urlencoded"
  # c.use Faraday::Response::Logger     # log request & response to STDOUT
  c.use Faraday::Adapter::NetHttp     # perform requests with Net::HTTP
end

def introduction
  puts "Welcome to the wonderful typing game.\n Please enter your name to start the game!\n When you are done, please enter 'stop'"  
  print "> "
  user = STDIN.gets.chomp()
  return user
end

def evaluate(word)
  begin 
    Timeout::timeout(5) do
      answer = STDIN.gets.chomp()
      if answer == word
        puts "Right!"
        SUCCESSES << word
      elsif answer == "stop"
        break
      else
        puts "Wrong!"
        FAILURES << word
      end
    end
  rescue Timeout::Error
    puts "You took too long!"
  end 
end

def start_game(user, conn)

  response = conn.get '/easy.json'

  JSON.parse(response.body).each do |word|
  	puts "#{user}, this is word #{word[0]}"
    %x(say #{word[1]})

    evaluate(word[1])
    next
  end
end

start_game(introduction, conn)

puts "You missed the following words:"

FAILURES.each do |f|
  puts f
end

puts "You got the following words:"

SUCCESSES.each do |f|
  puts f
end