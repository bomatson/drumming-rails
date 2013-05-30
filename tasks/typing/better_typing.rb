WORDS = ["randy", "fay", "gary"]

def evaluate(answer, word, status)
  sleep 2
  if answer == word
    puts "Right!"
  else
    puts "Wrong!"
    status = 'failure'
    return status
  end
end

def prompt
  failures = []
  WORDS.each do |word|
    %x(say #{word})
    answer = STDIN.gets.chomp()
    status = nil

    evaluate(answer, word, status)
    puts status.inspect

    if status == 'failure'
      failures << word
    end
    next
  end

  puts failures.inspect
end

prompt

# early version of getting the timing right, also broke out the logic to another func
# need to log success and failures, but I can't return the status string for some reason  

