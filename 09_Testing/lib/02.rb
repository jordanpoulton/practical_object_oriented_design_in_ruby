# Testing Incoming Messages

# Go to the 02_spec.rb

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    (rim + (tire * 2))
  end
#..
end

class Gear
  attr_accessor :chainring, :cog, :rim, :tire
  def initialize(options)
    @chainring = options[:chainring]
    @cog = options[:cog]
    @rim = options[:rim]
    @tire = options[:tire]
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end
end
