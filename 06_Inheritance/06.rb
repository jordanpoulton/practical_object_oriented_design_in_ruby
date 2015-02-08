# The very calling of super itself below means that Roadbike expects, nay requires, that one of its superclasses has a spares method, and that it returns a hash.
# Both send super in their initialize and spares methods, which creates a strong dependency.

class Bike
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size      = args[:size]
    @chain     = args[:chain]     || default_chain
    @tire_size = args[:tire_size] || default_tire_size
  end

  def spares
    {tire_size: tire_size,
      chain: chain
    }
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NotImplementedError
    "This #{self.class} cannot respond to:"
  end

end


class RoadBike < Bike
  attr_reader :tape_color

  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end

  def spares
    super.merge({tape_color: tape_color})
  end

  def default_tire_size
    '23'
  end
  #...
end

class MountainBike < Bike # This < is the code for 'inherits from'
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock  = args[:front_shock]
    @rear_shock   = args[:rear_shock]
    super(args)
  end

  def spares
    super.merge(rear_shock: rear_shock)
  end

  def default_tire_size
    '2.1'
  end
end

# If, for example, someone creates a new class (RecumbentBike) and forgets to send super in the initialize method, it will blow up...

class RecumbentBike < Bike
  attr_reader :flag

  def initialize(args)
    @flag = args[:flag]
  end

  def spares
    {flag: flag
    }
  end

  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end
end

# It won't have a valid size, chain or tire size because it doesn't do the call to super on initialize.

# Also, because it didn't send super in it's spares method, you'll be missing the tire and chain spares it needs. If you don't catch this in time, the Mechanic will be calling you when the brike is broken down in the rain and he doesn't have the right kit.

bent = RecumbentBike.new(flag: "Tall and Orange")
p bent.spares # =>{:flag=>"Tall and Orange"}

# Subclasses SHOULD NOT know how they need to interact with their superclasses. This is overly tight coupling and will cause trouble down the line. You should use HOOK MESSAGES
