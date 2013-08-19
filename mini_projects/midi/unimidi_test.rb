require 'micromidi'

input = UniMIDI::Input.first\

input.open do |input|

  loop do
    m = input.gets
    $stdout.puts(m)
    data = m.first[:data]

    element = data.first
    note = data[1]
    velocity = data[2]

    case element
    when 191
      puts 'I am a knob'
    when 159, 143
      puts 'Playing the keys'
      `afplay ~/Desktop/epic-drum.wav`
    else
      puts 'Something else'
    end
  end
end

# maybe play files from web with midi controller
# possible move on to resolume now, have controller trigger visuals