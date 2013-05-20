def scanner(dir) 
  directory = Dir.glob(dir + '/*')
  file = '/photo.png'

  if directory.include? dir + file
    puts "I found:" + file
  else
    puts 'Not found!'
  end
end

scanner(ARGV.first)