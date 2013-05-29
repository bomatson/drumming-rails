WORDS = ["randy", "fay", "gary"]

def prompt
  WORDS.each do |word|
    %x(say #{word})
    sleep 2 
    answer = STDIN.gets.chomp()
    if answer == word
      puts "Right!"
    else
      puts "Wrong!"
    end
  end
end

prompt

# need to make a timer method that executes instead of sleep 
# (unless I can escape or exit sleep)

