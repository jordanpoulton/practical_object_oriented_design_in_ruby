require 'forwardable'

class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  # Forwardable means that the object specified in 'def_delegators' - @parts, will have the size and each methods delegated to that object'

  # Including Enumerable now gives Array-like behavious to the parts object

  def initialize(parts)
    @parts = parts
  end

  def spares
    select {|part| part.needs_spare}
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name        = args[:name]
    @description = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end

class Bike
  attr_reader :size, :parts

  def initialize(args={})
    @size  = args[:size]
    @parts = args [:parts]
  end

  def spares
    @parts.spares
  end
end

chain = Part.new(name: 'chain', description: '10-speed')
road_tire = Part.new(name: 'tire_size', description: '23')
tape = Part.new(name: 'tape-color', description: 'red')

road_bike_parts = Parts.new([chain, road_tire, tape])

road_bike = Bike.new(
  size: 'L',
  parts: Parts.new([chain, road_tire, tape])
)

p road_bike.spares.size
p road_bike.parts.size

# There is still an issue though - the instigator of all this needs to know how to create Part objects, and to know which Part objects go with a road_bike, and how to manufacture the correct Parts object for a particular bike. This is a lot of knowledge, which implies high coupling, and will lead to issues down the road.
