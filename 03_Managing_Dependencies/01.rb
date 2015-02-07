# Here (using the old - incorrect - methodology) rather than passing in a wheel, the gear class creates a new wheel using the rim and tire data that it's given on initialization.

class Gear
  attr_accessor :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    (rim + (tire * 2))
  end

  def circumference
    diameter * Math::PI
  end
end

puts Gear.new(52, 11, 26, 1.5).gear_inches

# In this situation, Gear MASSIVELY depends on Wheel.

# A class "Wheel" must exist for it to function properly
# Gear also expects this class to respond to diameter
# It also expects that a Wheel is initialized with 2 arguments
# And that their order must be 'rim, tire' and not the other way around

# Any changes to wheel therefore necessarily imply a change would have to be made to Gear. This is building up TECHNICAL DEBT that makes the code confusing and hard to change or extend in the future

# This is called COUPLING, and should be avoided at all costs.

# NB - you also want to make sure that your TESTS are not too tightly coupled to your code. We'll get to that later.

# Every dependency is like a dot of glue that causes your classes to stick to the things it touches. A few dots are necessary, but you should only use the minimal amount.

