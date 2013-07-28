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

# stub timeout
# stub puts and gets
# mock successes and failures
def evaluate(word)
  begin 
    Timeout::timeout(5) do
      answer = gets.chomp()
      if answer == word
        puts "Right!"
        SUCCESSES << word
      else
        puts "Wrong!"
        FAILURES << word
      end
    end
  rescue Timeout::Error
    puts "You took too long!"
  end 
end

def post_score
  puts "You missed the following words:"

  FAILURES.each do |f|
    puts f
  end

  puts "You got the following words:"

  SUCCESSES.each do |f|
    puts f
  end
end


def check_resume(user, conn)
  wins = SUCCESSES.length
  if wins > 10
    start_game(user, conn, "hard")
  elsif wins <= 10 && wins > 3 
    start_game(user, conn, "medium")
  else
    puts "Please try again!"
    start_game(user, conn, "easy")
  end
end

def start_game(user, conn, difficulty = {})

  response = conn.get "/level/#{difficulty}"

  puts "Welcome to the #{difficulty} level. Please press enter to proceed"
  gets.chomp()
  
  JSON.parse(response.body).each do |word|
    puts "#{word}"
  	# puts "#{user}, this is word #{id}"
    %x(say -v Victoria #{word})

    evaluate(word)
    next
  end

  post_score
  check_resume(user, conn)
end

start_game(introduction, conn, "easy")
