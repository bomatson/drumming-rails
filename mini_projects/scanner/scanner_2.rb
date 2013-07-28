def scanner(dir, file) 
  directory = Dir.glob(dir + '/*')

  if directory.include? dir + '/' + file
    puts "I found: " + file
  else
    puts 'Not found!'
  end
end

scanner(ARGV.first, ARGV.last)