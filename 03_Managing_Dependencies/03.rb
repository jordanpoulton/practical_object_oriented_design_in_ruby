
# Remove Argument Order Dependencies
# In the following code, the Gear class can only be initialised with its arguments in the correct order, which makes it brittle.

class Gear
  attr_accessor :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end
#...
end

puts Gear.new(52, 11, Wheel.new(26, 1.5))

# A much more powerful initialization strategy is to pass an options hash, so the argument order does not matter


class Gear
  attr_accessor :chainring, :cog, :wheel
  def initialize(options)
    @chainring = options[:chainring]
    @cog = options[:cog]
    @wheel = options[:wheel]
  end
#...
end

puts Gear.new(
  chainring: 52,
  cog: 11,
  wheel: Wheel.new(26, 1.5)
)

# When initializing with an options hash, it's good practise to add defaults for the times when a specific setting is not included:

class Gear
  attr_accessor :chainring, :cog, :wheel
  def initialize(options)
    @chainring = options[:chainring] || 40
    @cog = options[:cog] || 18
    @wheel = options[:wheel]
  end
#...
end

puts Gear.new(
  wheel: Wheel.new(26, 1.5)
)

# In fact, it would be better to use the fetch method. Using the || operator means that if the setting returns false or nil it will be set to the default. Fetch allows these variables to be explicitly set to false or nil...

class Gear
  attr_accessor :chainring, :cog, :wheel
  def initialize(options)
    @chainring = options.fetch(:chainring, 40)
    @cog = options.fetch(:cog, 18)
    @wheel = options[:wheel]
  end
#...
end

puts Gear.new(
  wheel: Wheel.new(26, 1.5)
)

# And even better again would be to isolate the defaults into a wrapping method

class Gear
  attr_accessor :chainring, :cog, :wheel
  def initialize(options)
    options = defaults.merge(options)

    @chainring = options[:chainring]
    @cog = options[:cog]
    @wheel = options[:wheel]
  end

  def defaults
    {chainring: 40, cog: 18}
  end
#...
end

puts Gear.new(
  wheel: Wheel.new(26, 1.5)
)

