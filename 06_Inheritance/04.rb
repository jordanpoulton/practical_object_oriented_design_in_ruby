# If you try to call size on a MountainBike now, it will blow up. The size and spares methods are clearly shared by both classes, and need to be moved back up.

class Bike
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size      = args[:size]
    @chain     = args[:chain]
    @tire_size = args[:tire_size]
  end

  def spares
    {chain: '10 speed',
    }
  end
end


class RoadBike < Bike
  attr_reader :tape_color

  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end

  def spares
    super.merge{tape_color: tape_color}
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
end

# You should never skip the middleman here. Move all your code into the 'RoadBike' subclass and ONLY promote back up code that is shared across both subclasses.

# But - both SUBCLASSES have a default for tiresize (23 for roadbikes, 2.1 for Mountain bikes (mm vs inches!)). We need the Template Pattern
