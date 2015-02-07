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
    ratio * (rim + (tire * 2))
  end
end

puts Gear.new(52, 11, 26, 1.5).gear_inches
puts Gear.new(52, 11, 24, 1.25).gear_inches

# NB - Our old code would have returned an error here:
# puts Gear.new(52, 11).ratio
# Because our new code requires two extra arguments on initialization

# BUT we should ask ourselves, already, are we violating the single responsibility principle?

# A good rule of thumb - talk to your class as if it were a person...

# "Please Mr Gear, what is your ratio?" => Seems fair
# "Please Mr Gear, what are your gear inches?" => Is a little shaky
# "Please Mr Gear, what is your tire size?" => is downright ridiculous

# Also - what is the PURPOSE of the Gear class?
# Whatever its purpose, a gear having rims and tires doesn't sit comfortably.

# So what do we need - a Bicycle? A Wheel?

# A note on best practise

# DEPEND ON BEHAVIOUR, NOT DATA
# You see how in the ratio method, we don't use @chainring or @cog? We use an attr_accessor so that because we want to DEPEND on BEHAVIOUR, NOT DATA
# By wrapping the data in an accessor method, we change chainring and cog from data to behaviour, so we can refer to them as often as we want and when a change is made, we only need to make the change in one place.

# DON'T DEPEND ON COMPLICATED DATA STRUCTURES
# As mentioned in line 23, our initialization will fail if we do not provide the right number of arguments, in the right order.

# => How might you get around that?

# Make sure your methods, like your classes, have single responsibility
# gear_inches is unclear. It is actually saying that gear_inches are a product of the gear_ratio and the diameter of a wheel. So this method is calculating two things, and already too obscure:

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
    ratio * diameter
  end

  def diameter
    (rim + (tire * 2))
  end
end
# Here we have isolated the code for diameter, making it clearer, wrapping it in a seperate method
# Already you should be getting a stronger sense that a Wheel class may be necessary...

class Gear
  attr_accessor :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel=nil)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
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

@wheel = Wheel.new(26, 1.5)
puts @wheel.circumference

puts Gear.new(52, 11, @wheel).gear_inches
puts Gear.new(52, 11).ratio
