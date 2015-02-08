# To solve the problem of subclasses having to call super, you can have superclasses execute hook messages that exist solely to invite subclasses to contribute information by implementing matching methods.


class Bike
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size      = args[:size]
    @chain     = args[:chain]     || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    post_initialize
  end

  def post_initialize
    nil
  end
#..
end


class RoadBike < Bike
  attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end
  #...
end

# RoadBike no longer controls its initialization, instead, it contributes specializations to a larger, abstract initialization algorithm. This is defined in Bike, which itslef is responsible for sending the post_initialize message. Roadbike is still responsible for WHAT initialization it needs, just not for WHEN it occurs.

# This allows RoadBike to know less about Bike, reduces coupling between them and makes both more flexible

# We can use the same technique on the spares method:

class Bike
#..
  def spares
    {tire_size: tire_size,
      chain: chain
    }.merge(local_spares)
  end

  def local_spares
    {}
  end
end

class RoadBike < Bike
  #..
  def local_spares
    {tape_color: tape_color}
  end
end

# This preserves the specialization supplied by RoadBike with regards to its spares, but reduces its coupling to Bike - it doesn't need to know that Bike has a spares method, only that it needs a local_spares method and that it will be called when it is needed.
