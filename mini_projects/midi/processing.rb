require 'ruby-processing'
require 'unimidi'

def setup
  @input = ::UniMIDI::Input.first
  size 800, 600
  frame_rate 30
  smooth
  fill 0
  color_mode RGB, 100
end

def draw
  @input.open do |input|
    m = input.gets
    data = m.first[:data]
    background rand(255), data[1], rand(255)
  end
  triangle(rand(width), rand(height), rand(width), rand(height), rand(width), rand(height))
end
