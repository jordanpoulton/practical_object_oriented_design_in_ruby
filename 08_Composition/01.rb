# Composition is the act of combining distinct parts in a complex whole so that the whole becomes more than the sum of its parts.

# Music, for example, is composed. Software is similar.

# In composition, the larger object is connected to its parts via a HAS A relationship.

# EG - earlier, we hade a Bike that had spare_parts

# This could be refactored using composition, making the Parts its own class that implements the spares method, and using Dependency Injection:

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

class Parts
  attr_reader :chain, :tire_size

  def initialize(parts)
    @parts = parts
  end

  def spares
    @parts.select {|part| part.needs_spare}
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

chain = Part.new(name: 'chain', description: '10-speed')
road_tire = Part.new(name: 'tire_size', description: '23')
tape = Part.new(name: 'tape-color', description: 'red')

p road_bike_parts = Parts.new([chain, road_tire, tape])

road_bike = Bike.new(
  size: 'L',
  parts: Parts.new([chain, road_tire, tape])
  )
p road_bike.size
p road_bike.spares

# The key thing to notice here is that the 'spares' method used to return a hash, and now it the Parts class returns an array of Parts. BUT, composition tells us that the objects in this array don't have to be a KIND_OF the Part class, they just have to ACT like one - as in, they have to respond to name, description and needs_spare.

# Right now, we can do:

p road_bike.spares.size

# But we can't do

p road_bike.parts.size

# Because the first returns an array, which understands size, but the second returns an instance of Parts, which does not. We want Parts to respond AS IF it were an Array... how can we do that?

# Should we just hand code all the Array-like code we want Parts to implement?
# => (This isn't very dry)
# Should Parts inherit from Array? Perhaps Parts IS AN Array?
# => This will get messy, as it will inherit ALL of Array's functionality... (If you do Part + Parts the outcome will be... An Array!?) And saying that Parts IS AN Array seems strange...
# What we really want is to add traversing and search methods to Parts. This can be done with the Enumerables module.
