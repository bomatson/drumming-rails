def scanner(dir, file)   
  if Dir.glob(dir + '/*').include? dir + '/' + file
    puts "I found: " + file
  else
    puts 'Not found!'
  end
end

scanner(ARGV[0], ARGV[1]) unless ARGV[0..1].length < 2

#eliminated the directory variable and used better naming for 
#ARGV so if the user puts in multiple ARGV it still runs properly
#and if they don't put enough in scanner never runs