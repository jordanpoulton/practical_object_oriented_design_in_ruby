# With the code as it currently stands, the instigator needs to know how to create Part objects, and to know which Part objects go with a road_bike and which with a mountain_bike, and how to manufacture the correct Parts object for a particular bike. This is a lot of knowledge, which implies high coupling, and will lead to issues down the road.

# So what should we do? We need to wrap up all the knowledge of how to create and assign the right parts to a new object. We need to create a PartsFactory.


module PartsFactory
  def self.build(config,
    part_class  = Part,
    parts_class = Parts)

  parts_class.new(config.collect do |part_config|
    part_class.new(
      name:        part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true)
    )
  end
  )
  end
end

# This creates a new instance of Parts, initializing it with an array of part objects built from the information in config.

# It expects name to be in the first column of the array, description to be in the second, and an optional needs_spare boolean in the 3rd, which will default to true if nothing is passed.

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

require './02' # So that Part and Parts are understood...

p road_parts = PartsFactory.build(road_config)
p mountain_parts = PartsFactory.build(mountain_config)

# You might be asking yourself if the Part class is even necessary... You'd probably be right. Try to write Parts and the PartFactory, removing the Part class altogether. Try and come up with your own solution before scrolling down for mine...













































# I would remove the Part class by changing PartsFactory to use OpenStruct to create an object that plays the Part ROLE:

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

p mountain_parts = PartsFactory.build(mountain_config)
