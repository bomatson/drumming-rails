require 'random-word'

FAILURES = []

def evaluate(answer, word)
  if answer == word
    puts "Right!"
  else
    puts "Wrong!"
    FAILURES << word
  end
end

def prompt
  RandomWord.adjs.each do |word|
    puts word
    %x(say #{word})
    answer = STDIN.gets.chomp()
    break if answer == "stop"
    sleep 2 unless evaluate(answer, word)
    next
  end

end

prompt

puts "You missed the following words:"

FAILURES.each do |f|
  puts f
end

# using a random word generator to get legit words, and made a case for breaking
# out of the program once you've had enough
# next need to figure out 'levels' as well as better timing around answering

