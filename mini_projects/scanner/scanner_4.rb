def scanner(dir, file)   
  if Dir.glob(dir + '/*').include? dir + '/' + file
    puts "I found: " + file
  else
    puts 'Not found!'
  end
end

if ARGV[0..1].length >= 2
  scanner(ARGV[0], ARGV[1]) 
else
  puts "Please include the directory first, then the file you are searching for"
end

#added better error handling 