class Gear
  attr_accessor :chainring, :cog, :wheel
  def initialize(options)
    @chainring = options[:chainring]
    @cog = options[:cog]
    @wheel = options[:wheel]
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end
end
