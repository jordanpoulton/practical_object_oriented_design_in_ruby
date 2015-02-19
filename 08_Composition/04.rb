# We now have a Bike, which has Parts, which has a collection of Part objects, and a PartsFactory, and a configuration array for road and mountain bikes.

# The next ~60 lines of code replace the inheritance hierarchy from Chapter 6 with the composed object Bike.

# It works much like the inheritance hierarchy used to work, but the only difference to the end user is that the spares message now returns an array of Part-like objects, rather than a hash, as you can see when you run this code.

# AND - now that these new classes exist, it's very easy to create a new kind of bike, as you'll see at the bottom.

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

require 'forwardable'
class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  # Forwardable means that the object specified in 'def_delegators - @parts, will have the size and each methods delegated to that object'

  # Including Enumerable now gives Array-like behavious to the parts object

  def initialize(parts)
    @parts = parts
  end

  def spares
    select {|part| part.needs_spare}
  end
end

require 'ostruct'
module PartsFactory
  def self.build(config,
    parts_class = Parts)

  parts_class.new(config.collect do |part_config|
    create_part(part_config)
  end)
  end

  def self.create_part(part_config)
    OpenStruct.new(
      name:        part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true)
    )
  end
end

road_config = [
  ['chain', '10-speed'],
  ['tire_size', '23'],
  ['tape_color', 'red']
]

mountain_config = [
  ['chain', '10-speed'],
  ['tire_size', '2.1'],
  ['front_shock', 'Manitou', false],
  ['rear_shock', 'Fox']
]

# And now for the code to make it work!

road_bike = Bike.new(
  size: 'L',
  parts: PartsFactory.build(road_config)
  )

p road_bike.spares

mountain_bike = Bike.new(
  size: 'L',
  parts: PartsFactory.build(mountain_config)
  )

p mountain_bike.spares

# And look how easy it is to add a new kind of Bike!!

recumbent_config = [
  ['chain', '9-speed'],
  ['tire_size', '28'],
  ['flag', 'tall and orange']
]

recumbent_bike = Bike.new(
  size: 'L',
  parts: PartsFactory.build(recumbent_config)
  )

p recumbent_bike.spares
