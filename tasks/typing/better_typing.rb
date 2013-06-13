require 'random-word'
require 'timeout'

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
      elsif answer == "stop"
        break
      else
        puts "Wrong!"
        FAILURES << word
      end
    end
  rescue Timeout::Error => e
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

#I need to use catch and throw to escape?