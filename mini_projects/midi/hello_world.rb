require "micromidi"

@i = UniMIDI::Input.use(:first)

MIDI.using(@i, $stdout) do
  
  thru_except :note do |message|
    message.note += 12
    output(message)
  end
  
  join
  
end

#shes aliveeeee