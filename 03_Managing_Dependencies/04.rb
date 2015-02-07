# In some situations, you don't own the interface of the method you want to interact with. You may need to interact with a method that requires fixed order arguments, in which scenario you should wrap the interface in a module, which will isolate the external dependency:

module::SomeFramework
  class Gear
    attr_accessor :chainring, :cog, :wheel
    def initialize(chainring, cog, wheel=nil)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end
  end
  #...
end

# Wrap the interface to protect yourself from changes
module GearWrapper
  def self.gear(options)
    SomeFramework::Gear.new(
      options[:chainring],
      options[:cog],
      options[:wheel]
      )
  end
end

# So now you can do:
GearWrapper.gear(
  chainring: 52,
  cog: 11,
  wheel: Wheel.new(26, 1.5)
)

# This is the design pattern known as a FACTORY

