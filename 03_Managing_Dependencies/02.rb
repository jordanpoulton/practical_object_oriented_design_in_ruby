# Inject Dependencies

# When referencing the class Wheel from inside the Gear class, it becomes tightly coupled with it and is not reusable. In fact, all Gear needs to calculate its gear inches is to get a number from an object that responds to DIAMETER. One day we might want to get gear inches for a motorbike or a car - for disks or cylinders perhaps - but as it is the code cannot handle such things.

# Gear should not know, and does not need to know, how the diameter of a wheel is calculated. It just needs to know the diameter of a wheel, and nothing more.

# SO - we use Dependency Injection to PASS an object to Gear that responds to diameter

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

# Now our code is extendable, and we didn't even have to add any lines of code! Gear doesn't know about Wheels or their initialization patterns, it just needs to have a wheel passed into its @wheel variable. Gear is smarter - because it knows less.

# NB where you can't BREAK a dependency, you can at least ISOLATE it. You should see every dependency as an alien bacterium that's trying to infect your class - quarantine them.

# EG - if, for resource reasons, you weren't able to spend time refactoring to inject the dependency in to Gear, you could do:

class Gear
  attr_accessor :chainring, :cog, :wheel
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end

  def gear_inches
    ratio * wheel.diameter
  end
#...
end

# Or, even better than this, would be:

class Gear
  attr_accessor :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * wheel.diameter
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
#...
end

# In both instances Gear knows too much, but we have reduced the number of dependencies AND made the dependency more explicit.

# A HUGE red flag should be cases where an object sends messages to anything other than self

# line 58!!!!

# In these cases, you should always seek to isolate this vulnerability into it's own method so if and when it breaks, the side effects to Gear will be confined to this one wrapping method.

class Gear
  attr_accessor :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * diameter
  end

  def diameter
    wheel.diameter
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
#...
end
