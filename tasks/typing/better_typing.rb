WORDS = ["randy", "fay", "gary"]

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
  WORDS.each do |word|
    %x(say #{word})
    answer = STDIN.gets.chomp()
    sleep 2 unless evaluate(answer, word)
    next
  end

end

prompt

puts "You missed the following words:"

FAILURES.each do |f|
  puts f
end

# early version of getting the timing right, also broke out the logic to another func
# need to log success and failures, but I can't return the status string for some reason  

