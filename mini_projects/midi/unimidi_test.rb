require 'unimidi'

input = UniMIDI::Input.first
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
    else
      puts 'Something else'
    end
  end
end