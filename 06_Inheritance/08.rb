#Final code

class Bike
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size      = args[:size]
    @chain     = args[:chain]     || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  def post_initialize
    nil
  end

  def spares
    {tire_size: tire_size,
      chain: chain
    }.merge(local_spares)
  end

  def local_spares
    {}
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

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def local_spares
    {tape_color: tape_color}
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bike # This < is the code for 'inherits from'
  attr_reader :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock  = args[:front_shock]
    @rear_shock   = args[:rear_shock]
  end

  def spares
    {rear_shock: rear_shock}
  end

  def default_tire_size
    '2.1'
  end
end

# And now it's super easy to add a new specialization...

class RecumbentBike < Bike
  attr_reader :flag

  def post_initialize(args)
    @flag = args[:flag]
  end

  def local_spares
    {flag: flag}
  end

  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end
end

bent = RecumbentBike.new(flag: "Short and stubby")
p bent.spares
