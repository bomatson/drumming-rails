require 'random-word'
require 'timeout'

class Level
  attr_accessor :success_count

  def initialize(success_count = 0)

    @success = success_count
  end
end

# EASY = RandomWord.adjs.to_a.take(10)
# MEDIUM = RandomWord.adjs.to_a.take(30)
# HARD = RandomWord.adjs.to_a.take(100)
SUCCESSES = []

FAILURES = []

def introduction
  puts "Welcome to the wonderful typing game.\n Please enter your name to start the game!\n When you are done, please enter 'stop'"  
  print ">"
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

def start_game(user)

  RandomWord.adjs.each_with_index do |word, idx|
    puts "Mr. #{user}, this is word #{idx + 1}"
    %x(say #{word})
    evaluate(word)
    next
  end

end

start_game(introduction)

puts "You missed the following words:"

FAILURES.each do |f|
  puts f
end

puts "You got the following words:"

SUCCESSES.each do |f|
  puts f
end

#I need to use catch and throw to escape in order to stop the game?
#create levels and start using them once the success count gets high enough, use level class