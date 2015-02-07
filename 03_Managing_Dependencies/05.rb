# Remember - direction of dependency can be reversed. You could just as easily have had Wheel depending on Gear rather than Gear depending on Wheel:

class Gear
  attr_accessor :chainring, :cog
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def gear_inches(diameter)
    ratio * diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

class Wheel
  attr_reader :rim, :tire, :gear

  def initialize(rim, tire, chainring, cog)
    @rim = rim
    @tire = tire
    @gear = Gear.new(chainring, cog)
  end

  def diameter
    (rim + (tire * 2))
  end

  def gear_inches
    gear.gear_inches(diameter)
  end
end

p Wheel.new(26,1.5,52,11).gear_inches

# When deciding on the direction of a dependency, remember: "Depend on things that change less often than you do"

# Some classes change more often than others
# Concrete classes change more often than abstract classes
# Changing a class that has many dependencies will result in widespread consequences
