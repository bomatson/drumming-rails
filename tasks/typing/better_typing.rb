require 'random-word'

FAILURES = []

def introduction
  puts "Welcome to the wonderful typing game.\n Please enter your name to start the game!\n When you are done, please enter 'stop'"  
  print ">"
  user = STDIN.gets.chomp()
  return user
end

def evaluate(answer, word)
  if answer == word
    puts "Right!"
  else
    puts "Wrong!"
    FAILURES << word
  end
end

def start_game(user)
  RandomWord.adjs.each_with_index do |word, idx|
    puts "Mr. #{user}, this is word #{idx + 1}"
    %x(say #{word})
    answer = STDIN.gets.chomp()
    break if answer == "stop"
    sleep 2 unless evaluate(answer, word)
    next
  end

end

start_game(introduction)

puts "You missed the following words:"

FAILURES.each do |f|
  puts f
end

# made it seem more like a game, and included the index when iterating through words
# need levels and timer
