class Bike
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size      = args[:size]
    @chain     = args[:chain]     || default_chain
    @tire_size = args[:tire_size] || default_tire_size
  end

  def spares
    {chain: '10 speed'
    }
  end

  def default_chain
    '10-speed'
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

road_bike = RoadBike.new(
  size: 'M',
  tape_color: 'red'
  )

p road_bike.tire_size

mountain = MountainBike.new(
  size: 'S',
  front_shock: 'Manitou',
  rear_shock: 'Fox'
  )

p mountain.tire_size

# Seems like we solved the problem, right? Not exactly.

# Firstly, Bike sends 'default_tire_size', but doesn't implement it itself. Imagine FastFeet were to add a new Bike category - Recumbent - low long bikes where the rider lays down. What if the next developer creates the class but forgets to implement a default_tire_size method? It will blow up.


class RecumbentBike < Bike
  def default_chain
    '9-speed'
  end
end

bent = RecumbentBike.new # => (NameError): Undefined local variable or method `default_tire_size' for #<RecumbentBike:0x007fc00d0f6fe8 @size=nil, @chain="9-speed">

# One option is to be more specific in the Bike code, and add in:

class Bike
  #..
  def default_tire_size
    raise NotImplementedError
    "This #{self.class} cannot respond to:"
  end
end

# Which means that there will be a user friendly error if the next developer forgets to implement the method in a subclass

# BUT still - there is too much coupling between our Bike class and it's subclasses, and we can improve this.
