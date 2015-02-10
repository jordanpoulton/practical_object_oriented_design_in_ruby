class Wheel
  attr_reader :rim, :tire

  def initialize(rim=26, tire=1.5)
    @rim = rim
    @tire = tire
  end

  def diameter
    (rim + (tire * 2))
  end
#..
end

