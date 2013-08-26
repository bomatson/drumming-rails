require 'ruby-processing'
require 'unimidi'

def setup
  @input = ::UniMIDI::Input.first
  size 800, 600
  frame_rate 30
  smooth
  fill 0
end

end
def draw
  @input.open do |input|
    m = input.gets
    data = m.first[:data]
    puts data
    background data.first
  end
end
