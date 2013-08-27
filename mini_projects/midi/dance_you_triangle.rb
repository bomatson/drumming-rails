require 'ruby-processing'

def setup
  size 200, 200
  @left_leg_x = 50
  @left_leg_y = 150
  @left_leg_direction = 1
  @speed = 2.4
end

def draw
  @left_leg_x = @left_leg_x + (@left_leg_direction * @speed)

  respect_the_boundaries

  triangle(@left_leg_x,150, 150, 150 ,100, 35)
end

def respect_the_boundaries
  if @left_leg_x > width - 10 || @left_leg_x < 10
    @left_leg_direction *= -1
  end
end
